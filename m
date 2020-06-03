Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4572B20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tYgKOpxv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="j5tgOuQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFCTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:02:12 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59946 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgFCTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:02:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4E7038EE10C;
        Wed,  3 Jun 2020 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591210931;
        bh=Wt5yO3RIAVSuQI0FXzR9uphWwJwRA94DtPjtTGGrjmg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tYgKOpxvQWk0GivCIXWOn2Oe5AWlQVPqEpwRBr+cGaerXJTH18ciQH8HRH1F1UoNG
         SXySXBA1pkU/jTzVhuvAJC6qwIJ17yf35kizCcDucpQL5blBwTCbER+24GqLISlsPL
         lRvEZ4z5azznPQWWv1h1sOoOuwxHO5/4k5uZNmsM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gbL326jwZz7r; Wed,  3 Jun 2020 12:02:10 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A90878EE0DF;
        Wed,  3 Jun 2020 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591210930;
        bh=Wt5yO3RIAVSuQI0FXzR9uphWwJwRA94DtPjtTGGrjmg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j5tgOuQk9khBWshrGTaReeF1m4rYp5uqmAOaBA1uQoQHThE10yXM7HgQDBNmawgDB
         bWygpAQiZcLuFHDp6F+VBTqlPaa0Om1gRuwEzJAN7euT6Fj7UawBh3fngqGAZvHbB/
         Ipomli+452K4rncMB9yDS2ps1lQO/SEnrI4l/LGg=
Message-ID: <1591210928.13983.24.camel@HansenPartnership.com>
Subject: Re: kobject_init_and_add is easy to misuse
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Jun 2020 12:02:08 -0700
In-Reply-To: <20200603183650.GI6578@ziepe.ca>
References: <20200602115033.1054-1-wanghai38@huawei.com>
         <20200602121035.GL19604@bombadil.infradead.org>
         <1591111514.4253.32.camel@HansenPartnership.com>
         <20200602173603.GB3579519@kroah.com>
         <1591127656.16819.7.camel@HansenPartnership.com>
         <20200602200756.GA3933938@kroah.com>
         <1591134670.16819.18.camel@HansenPartnership.com>
         <20200603002205.GE6578@ziepe.ca>
         <1591207475.4462.41.camel@HansenPartnership.com>
         <20200603183650.GI6578@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-03 at 15:36 -0300, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2020 at 11:04:35AM -0700, James Bottomley wrote:
> > On Tue, 2020-06-02 at 21:22 -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 02, 2020 at 02:51:10PM -0700, James Bottomley wrote:
> > > 
> > > > My first thought was "what?  I got suckered into creating a
> > > > patch", thanks ;-)  But now I look, all the error paths do
> > > > unwind back to the initial state, so kfree() on error looks to
> > > > be completely correct. 
> > > 
> > > It doesn't fully unwind if the kobject is put into a kset, then
> > > another thread can get the kref during kset_find_obj() and
> > > kfree() won't wait for the kref to go to 0. It must use put.
> > 
> > That does seem a bit contrived: the only failure
> > kobject_add_internal() can get after kobj_kset_join() is from
> > directory creation.  If directory creation fails, no name appears
> > in sysfs and no event for the name is sent, how did another thread
> > get the name to pass in to kset_find_obj()?
> 
> The other thread just guesses in a hostile way? 
> 
> Eg it looks like the iommu stuff just feeds in user data to
> kobj_kset_join().

Well, if we have to go down the rabbit hole this far, it turns out to
be fixable because of the state_in_sysfs flag:

@@ -899,7 +903,8 @@ struct kobject *kset_find_obj(struct kset *kset, const char *name)
 	spin_lock(&kset->list_lock);
 
 	list_for_each_entry(k, &kset->list, entry) {
-		if (kobject_name(k) && !strcmp(kobject_name(k), name)) {
+		if (kobject_name(k) && k->state_in_sysfs &&
+		    !strcmp(kobject_name(k), name)) {
 			ret = kobject_get_unless_zero(k);
 			break;
 		}

That would ensure the name can't be found until the sysfs directory
creation has succeeded, which would be the point from which
kobject_init_and_add() can't fail.

James

