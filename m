Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D32AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E670A206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IvE2SWfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgESTg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:36:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D8AC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:36:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l21so370666eji.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3X3ieRi81fp1iWOzH1htJLq7a4gE8XcQKzYdnELS3Rg=;
        b=IvE2SWfNyc1HEWm849hzLIMS27zVegpHfrML4bRM8JYlxyx8dpPRhSI1u7KT25QOfZ
         0cMS4gkm4PDLyry0RnUBcQOzKKn6nCIahXtSV1VGrB9gJSsRoN5wxZilUI/lg8LkkNbx
         rR34iurepjdrl4AU2NcaZh4P42lBri8KaaQShNexJBPe0UrX1mqDuf2ndDlVVjczb+VL
         OGh4T3sWxiQHcG7ZsnFsfr7Qnb+DUO9J5Uamb1+FgigyPhvAOQzsTYD7BF/4kbOdV4AA
         x7f33EiRO/23h/DSLENU5khjyBb0uQHa1tKnwDVQC+LHa02e2D5VJOHDNW0KcNClsrKf
         Bk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3X3ieRi81fp1iWOzH1htJLq7a4gE8XcQKzYdnELS3Rg=;
        b=qyx0+yShcLKIxYXAyx+R5l2g2vid5tWUndndjTjOYS09+9oXie7PPNTVNvkypTWF+b
         g0DvEKk0CXzSsOqrze922F5PuqMgJsQyisM5rbaShX4wzcrfr7vaT4DJ53qJRuaO/glQ
         ClkmaU93Ole0T6rS+DS6lAEqCzn7rFOJeVySramc6k/sqOpxkMjyty0EKi3CmxoYLhIE
         KcdC7t8xG3h4ALSUHHGMayXxagYx+vmJ3sYFokJohyBFGiMUOZ3BOqmIus94hSS5xK10
         6i3n4xwyAB8h/jiyUZALmR47KEffH30KLukkYd4PGuJvE6f3786JIVJa49gFJuNXvJfb
         t/Fg==
X-Gm-Message-State: AOAM531onZyLy1n1Ca1sW3ulYR1kF/n26QxIwSObta3RJ5yPF16Mddoa
        2Yl4caAcN73mnnf/ZwLsu3Vtqo8DTvtCGOg0oXogLQ==
X-Google-Smtp-Source: ABdhPJzVXCcjEzanIYQFTBgeXCnzx374fZZtsMpCor7WLQqXWHf7+pUq3xFxoTLKhSlp3iAkff0MpR/K14RfFbGsVUA=
X-Received: by 2002:a17:906:a3d1:: with SMTP id ca17mr760410ejb.174.1589916986746;
 Tue, 19 May 2020 12:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200519184634.GZ16070@bombadil.infradead.org>
In-Reply-To: <20200519184634.GZ16070@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 May 2020 12:36:15 -0700
Message-ID: <CAPcyv4jgjoLqsV+aHGJwGXbCSwbTnWLmog5-rxD2i31vZ2rDNQ@mail.gmail.com>
Subject: Re: [PATCH v2] /dev/mem: Revoke mappings when a driver claims the region
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

On Tue, May 19, 2020 at 11:46 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, May 19, 2020 at 12:03:06AM -0700, Dan Williams wrote:
> > +void revoke_devmem(struct resource *res)
> > +{
> > +     struct inode *inode = READ_ONCE(devmem_inode);
> > +
> > +     /*
> > +      * Check that the initialization has completed. Losing the race
> > +      * is ok because it means drivers are claiming resources before
> > +      * the fs_initcall level of init and prevent /dev/mem from
> > +      * establishing mappings.
> > +      */
> > +     smp_rmb();
> > +     if (!inode)
> > +             return;
>
> Which wmb() is this pairing with?
>
> > +static int devmem_init_inode(void)
> > +{
> > +     static struct vfsmount *devmem_vfs_mount;
> > +     static int devmem_fs_cnt;
> > +     struct inode *inode;
> > +     int rc;
> > +
> > +     rc = simple_pin_fs(&devmem_fs_type, &devmem_vfs_mount, &devmem_fs_cnt);
> > +     if (rc < 0) {
> > +             pr_err("Cannot mount /dev/mem pseudo filesystem: %d\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     inode = alloc_anon_inode(devmem_vfs_mount->mnt_sb);
> > +     if (IS_ERR(inode)) {
> > +             rc = PTR_ERR(inode);
> > +             pr_err("Cannot allocate inode for /dev/mem: %d\n", rc);
> > +             simple_release_fs(&devmem_vfs_mount, &devmem_fs_cnt);
> > +             return rc;
> > +     }
> > +
> > +     /* publish /dev/mem initialized */
> > +     WRITE_ONCE(devmem_inode, inode);
> > +     smp_wmb();
> > +
> > +     return 0;
>
> ... is that this one?  I don't see what it's guarding against.  Surely if
> it's needed to ensure that the writes to 'inode' have happened before
> the write of the inode pointer, the smp_wmb() needs to be before the
> WRITE_ONCE, not after it?

Whoops, yes. Thanks for the catch.
