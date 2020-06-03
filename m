Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EB52068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ugTnLRUV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mDtdse0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFCSEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:04:40 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59394 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgFCSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:04:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 602538EE10C;
        Wed,  3 Jun 2020 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591207478;
        bh=nyF4ZNrk3Tv6mEkMqr1kGc6nsVLVMvXsy+KGMvTU+eM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ugTnLRUVTG6gL9VguUYtukOS5HWcTT8LHJyCfv39HZ3y1ZurRZmiRtdtYzrbBsGnE
         6qMAiL3n8WXfYrLpcXYGauhjNVkrCVnv9olEVawEkWsFkIb3wjIfYHoeP3zFSfhnnk
         g2zlHPTNlU0Scu+lerlU40Y+kFXlHT0/k/FSYM1U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zlAJS75A4beK; Wed,  3 Jun 2020 11:04:37 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EB0EE8EE0DF;
        Wed,  3 Jun 2020 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591207477;
        bh=nyF4ZNrk3Tv6mEkMqr1kGc6nsVLVMvXsy+KGMvTU+eM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mDtdse0EcgtJXc2ZTI7eSLKESTigp9T388FW8VMlxAk2aEZOsF/j4q1WHgLLDW5gz
         HwIEljgUmGuw+15+SkQHCkQg7m/Dm+LcFanDugHhwY834hmdke+pxpNPVs8Py+f6gu
         2iF7SxrwX/FPtGRf3GYtrfBi9wfLPxR+kTQC2YLk=
Message-ID: <1591207475.4462.41.camel@HansenPartnership.com>
Subject: Re: kobject_init_and_add is easy to misuse
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Jun 2020 11:04:35 -0700
In-Reply-To: <20200603002205.GE6578@ziepe.ca>
References: <20200602115033.1054-1-wanghai38@huawei.com>
         <20200602121035.GL19604@bombadil.infradead.org>
         <1591111514.4253.32.camel@HansenPartnership.com>
         <20200602173603.GB3579519@kroah.com>
         <1591127656.16819.7.camel@HansenPartnership.com>
         <20200602200756.GA3933938@kroah.com>
         <1591134670.16819.18.camel@HansenPartnership.com>
         <20200603002205.GE6578@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-02 at 21:22 -0300, Jason Gunthorpe wrote:
> On Tue, Jun 02, 2020 at 02:51:10PM -0700, James Bottomley wrote:
> 
> > My first thought was "what?  I got suckered into creating a patch",
> > thanks ;-)  But now I look, all the error paths do unwind back to
> > the initial state, so kfree() on error looks to be completely
> > correct. 
> 
> It doesn't fully unwind if the kobject is put into a kset, then
> another thread can get the kref during kset_find_obj() and kfree()
> won't wait for the kref to go to 0. It must use put.

That does seem a bit contrived: the only failure kobject_add_internal()
can get after kobj_kset_join() is from directory creation.  If
directory creation fails, no name appears in sysfs and no event for the
name is sent, how did another thread get the name to pass in to
kset_find_obj()?

James

