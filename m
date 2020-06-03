Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEFBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D056B2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pYX8WSvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFCTaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:30:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7759CC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:30:15 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c12so3405215qkk.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HvznEnzV+HRJyOZqdmIsBfXXgi2q857VNMTI/lWqqUk=;
        b=pYX8WSvGiUcHnZYmypMSDM3XS83clLrqguMbokWHtX1j+TNBGYFLPmZzzomEZpD+Ll
         efM0e+VKBYFLw40X+m/vJ5PXxNxMUAE7ytbux9ykJ/jl0wfyyYYQqwZ5LaZLkNRTvgKI
         9yd/HorVj/PX3fOe1WQuODI6Wb5V1SKwb5ifwH6yPNkA9Y19m6yX24YAQcKQCt02cGL5
         hQnn0sJ6kOlmhIOj+50IDoO+H+LyWiMMipoTrAzaeOLT2YU8xAej+tEq1vs/jJ7kxjU0
         0lTCLl5noCiRkDgQPsaqJ+Xr+ZcAkEvqtwVji76GBKyksSZIQZBclExcxWmVNgf7C+oX
         ngyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvznEnzV+HRJyOZqdmIsBfXXgi2q857VNMTI/lWqqUk=;
        b=MEuKuHrVXCpYk/DtCNXsqcMTrgsO0xHASL6DTDk7Q/mpwkJ2Y34ttOatypA62m6KYR
         KaSmDs0qaNRFt8LDOs5T+avuAW+QWklEloab2RV6q4XguU510jkGlVoHLxBrjTBn1Hit
         vOaHkx+hsX0sv1JQKIYQVzXdiZ6j2kSc3f4FpPAYQFKqn8kh2hhSrtbeDSybNzKdQ2Yy
         C8I14j/dchOhX5+culxVdxOPgz7EdtsT1DYZX0iS1vD5IoNqexMxNt/mKe0JCp0CmU9x
         oUsxU2AYlhvslj00MyJJTnuHSdTDoyNrxpA+b6uzM5K7NtefU30oYOIxc2HYFcagwz2G
         6S+A==
X-Gm-Message-State: AOAM530pe91J5ioC8Rd46veIryDBL2i96ZB86Q7Biv0WNsOoF978mEaw
        q8JhPAzf7oZuh2mkgKz+Q7dpa7lcqaM=
X-Google-Smtp-Source: ABdhPJzEsmvZzzrBYgh28D8B3cuOKKWtUVzwpL/VgReBvZTpiSClwaI3lHYdVSOuaK6hBzbKDNBlHg==
X-Received: by 2002:a37:be43:: with SMTP id o64mr1230241qkf.322.1591212614308;
        Wed, 03 Jun 2020 12:30:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 80sm2229655qkl.116.2020.06.03.12.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:30:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgZ5Z-000ul9-4V; Wed, 03 Jun 2020 16:30:13 -0300
Date:   Wed, 3 Jun 2020 16:30:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: kobject_init_and_add is easy to misuse
Message-ID: <20200603193013.GJ6578@ziepe.ca>
References: <20200602121035.GL19604@bombadil.infradead.org>
 <1591111514.4253.32.camel@HansenPartnership.com>
 <20200602173603.GB3579519@kroah.com>
 <1591127656.16819.7.camel@HansenPartnership.com>
 <20200602200756.GA3933938@kroah.com>
 <1591134670.16819.18.camel@HansenPartnership.com>
 <20200603002205.GE6578@ziepe.ca>
 <1591207475.4462.41.camel@HansenPartnership.com>
 <20200603183650.GI6578@ziepe.ca>
 <1591210928.13983.24.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591210928.13983.24.camel@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:02:08PM -0700, James Bottomley wrote:
> On Wed, 2020-06-03 at 15:36 -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 03, 2020 at 11:04:35AM -0700, James Bottomley wrote:
> > > On Tue, 2020-06-02 at 21:22 -0300, Jason Gunthorpe wrote:
> > > > On Tue, Jun 02, 2020 at 02:51:10PM -0700, James Bottomley wrote:
> > > > 
> > > > > My first thought was "what?  I got suckered into creating a
> > > > > patch", thanks ;-)  But now I look, all the error paths do
> > > > > unwind back to the initial state, so kfree() on error looks to
> > > > > be completely correct. 
> > > > 
> > > > It doesn't fully unwind if the kobject is put into a kset, then
> > > > another thread can get the kref during kset_find_obj() and
> > > > kfree() won't wait for the kref to go to 0. It must use put.
> > > 
> > > That does seem a bit contrived: the only failure
> > > kobject_add_internal() can get after kobj_kset_join() is from
> > > directory creation.  If directory creation fails, no name appears
> > > in sysfs and no event for the name is sent, how did another thread
> > > get the name to pass in to kset_find_obj()?
> > 
> > The other thread just guesses in a hostile way? 
> > 
> > Eg it looks like the iommu stuff just feeds in user data to
> > kobj_kset_join().
> 
> Well, if we have to go down the rabbit hole this far, it turns out to
> be fixable because of the state_in_sysfs flag:
> 
> @@ -899,7 +903,8 @@ struct kobject *kset_find_obj(struct kset *kset, const char *name)
>  	spin_lock(&kset->list_lock);
>  
>  	list_for_each_entry(k, &kset->list, entry) {
> -		if (kobject_name(k) && !strcmp(kobject_name(k), name)) {
> +		if (kobject_name(k) && k->state_in_sysfs &&
> +		    !strcmp(kobject_name(k), name)) {
>  			ret = kobject_get_unless_zero(k);
>  			break;
>  		}
> 
> That would ensure the name can't be found until the sysfs directory
> creation has succeeded, which would be the point from which
> kobject_init_and_add() can't fail.

Convoluted, and needs something on the store of state_in_sysfs too,
but could work.

It feels more robust to stick with the put though..

Jason
