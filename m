Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D72AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0013C207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YHaJTaKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgEUSVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEUSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:21:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CAFC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:21:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so9964755ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWcAuNkG3Q5ladsYnp2Qj5hPS9giuhw1tw7IgS1xLrQ=;
        b=YHaJTaKrWRFIp5Wimods+wiaz57YIkTSSlG9HyT7kLZhocQDTud/WBh02H+ZDUkhhb
         mPeqxg/m9y24527uae0kbcYJqm9OFmoO0ftV/1Ogl8NHZEsIcI07s5AyUK44CVePR0p4
         nPRqkI+HadfYvzkdLt4+YkmGC5XEjcslDieJMrxQtMmSJyyvFnyWEx8XXV9jj3aZ3JpU
         SHPO2o+y8T0L7ZZYfE41Of1xtiu0OMmIX8oC4KTq7OJFRXx0nzfw5SHsAWDpTFc7lerJ
         ChPUyi2B2dd6IE6ijk6+FXgCeQC8gsy3uq8cx//28zWN1Xcb/pQpIcBDdo46TWYlFXno
         /P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWcAuNkG3Q5ladsYnp2Qj5hPS9giuhw1tw7IgS1xLrQ=;
        b=UgopbKbLyyHTgaMqKAbOh6ivxLcVVuB+Aw54aT5VyPF6AF5c6rb3SxERy0JCxUT79l
         9gDu6q3YfkE45DdM4Urni7dpud6+KaJkTo/+X+7Ry3qZkKyib7Rcyo7z4MalvJO9a7dj
         uqw7gRi8NIJiPE/zHRwcj8cDuJg33TZy3LQ8hCSB/UhDp8OdOUBokWs+bPn6SXlwFgNA
         DfZmbsDSgDRpxlifJn/yj2wgmxw3By7SBweSo3wunk7UsKH/wA117c1htWuf31IpNJHj
         9kffTDr1H74aZ6bRU0Ydi8+UUYQ9HWuuGebX+Ghm4i2/ucWtj147hod5UYLdXbFNJcs7
         aH9Q==
X-Gm-Message-State: AOAM532ZIoKD4dXP14j7o9ryxLKPjvOWT6qhOLtttd7rlRylVtuhlePg
        9M1iN64JNtKIB/1S2Idpx+/WC4dJWCAzaQrULC7j0w==
X-Google-Smtp-Source: ABdhPJw+9l78+8zHLz+/2DhBtnmCgCs+oOqAtGPX7nJfKRXNaBSn7tMRQNWiFCPgsb4mrARCi03l1U6DvUnk4H890XI=
X-Received: by 2002:a17:906:edd5:: with SMTP id sb21mr5050697ejb.204.1590085279923;
 Thu, 21 May 2020 11:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <159002475918.686697.11844615159862491335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200521022628.GE16070@bombadil.infradead.org> <CAPcyv4jpKo7s-bqM2TN2BS73ssOVfhdNaooziZMs2zULH6xs-g@mail.gmail.com>
 <CAPcyv4hvCYF7wCtYwAXi-Okpxm-W+W=nRRJkmSHFg0p+Z2p17A@mail.gmail.com> <20200521114115.GA28818@bombadil.infradead.org>
In-Reply-To: <20200521114115.GA28818@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 May 2020 11:21:08 -0700
Message-ID: <CAPcyv4j2+7XiJ9BXQ4mj_XN0N+rCyxch5QkuZ6UsOBsOO1+2Vg@mail.gmail.com>
Subject: Re: [PATCH v3] /dev/mem: Revoke mappings when a driver claims the region
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 4:41 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 20, 2020 at 09:39:49PM -0700, Dan Williams wrote:
> > On Wed, May 20, 2020 at 9:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > On Wed, May 20, 2020 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > On Wed, May 20, 2020 at 06:35:25PM -0700, Dan Williams wrote:
> > > > > +static struct inode *devmem_inode;
> > > > > +
> > > > > +#ifdef CONFIG_IO_STRICT_DEVMEM
> > > > > +void revoke_devmem(struct resource *res)
> > > > > +{
> > > > > +     struct inode *inode = READ_ONCE(devmem_inode);
> > > > > +
> > > > > +     /*
> > > > > +      * Check that the initialization has completed. Losing the race
> > > > > +      * is ok because it means drivers are claiming resources before
> > > > > +      * the fs_initcall level of init and prevent /dev/mem from
> > > > > +      * establishing mappings.
> > > > > +      */
> > > > > +     smp_rmb();
> > > > > +     if (!inode)
> > > > > +             return;
> > > >
> > > > But we don't need the smp_rmb() here, right?  READ_ONCE and WRITE_ONCE
> > > > are a DATA DEPENDENCY barrier (in Documentation/memory-barriers.txt parlance)
> > > > so the smp_rmb() is superfluous ...
> > >
> > > Is it? I did not grok that from Documentation/memory-barriers.txt.
> > > READ_ONCE and WRITE_ONCE are certainly ordered with respect to each
> > > other in the same function, but I thought they still depend on
> > > barriers for smp ordering?
> > >
> > > > > +
> > > > > +     /* publish /dev/mem initialized */
> > > > > +     smp_wmb();
> > > > > +     WRITE_ONCE(devmem_inode, inode);
> > > >
> > > > As above, unnecessary barrier, I think.
> > >
> > > Well, if you're not sure, how sure should I be?
> >
> > I'm pretty sure they are needed, because I need the prior writes to
> > initialize the inode to be fenced before the final write to publish
> > the inode. I don't think WRITE_ONCE() enforces that prior writes have
> > completed.
>
> Completed, no, but I think it does enforce that they're visible to other
> CPUs before this write is visible to other CPUs.
>
> I'll quote relevant bits from the document ...
>
>  (2) Data dependency barriers.
>
>      A data dependency barrier is a weaker form of read barrier.  In the case
>      where two loads are performed such that the second depends on the result
>      of the first (eg: the first load retrieves the address to which the second
>      load will be directed), a data dependency barrier would be required to
>      make sure that the target of the second load is updated after the address
>      obtained by the first load is accessed.
>
> [...]
> SMP BARRIER PAIRING
> -------------------
> [...]
>         CPU 1                 CPU 2
>         ===============       ===============================
>         a = 1;
>         <write barrier>
>         WRITE_ONCE(b, &a);    x = READ_ONCE(b);
>                               <data dependency barrier>
>                               y = *x;
>

Oh, I read those <* barrier> lines as a requirement not an implied
side effect of READ/WRITE_ONCE(). I can see that WRITE_ONCE() is
effectively a barrier() and READ_ONCE() includes
smp_read_barrier_depends(). I'll drop.

>
> > > >
> > > > > +     /*
> > > > > +      * Use a unified address space to have a single point to manage
> > > > > +      * revocations when drivers want to take over a /dev/mem mapped
> > > > > +      * range.
> > > > > +      */
> > > > > +     inode->i_mapping = devmem_inode->i_mapping;
> > > > > +     inode->i_mapping->host = devmem_inode;
> > > >
> > > > umm ... devmem_inode->i_mapping->host doesn't already point to devmem_inode?
> > >
> > > Not if inode is coming from:
> > >
> > >      mknod ./newmem c 1 1
> > >
> > > ...that's the problem that a unified inode solves. You can mknod all
> > > you want, but mapping and mapping->host will point to a common
> > > instance.
>
> I don't think I explained myself well enough.
>
> When we initialise devmem_inode, does devmem_inode->i_mapping->host point
> to somewhere other than devmem_inode?
>
> I appreciate in this function, inode->i_mapping->host will point to inode.
> But we're now changing i_mapping to be devmem_inode's i_mapping.  Why
> do we need to change devmem_inode's i_mapping->host pointer?
>

Yeah, mistook your comment. The setting of ->host is indeed redundant.
