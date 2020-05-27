Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2227C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9282088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbgE0KQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:16:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387899AbgE0KQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:16:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27984ABC7;
        Wed, 27 May 2020 10:16:22 +0000 (UTC)
Date:   Wed, 27 May 2020 12:16:18 +0200
From:   Jiri Bohac <jbohac@suse.cz>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, jmorris@namei.org, mjg59@google.com,
        dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
Message-ID: <20200527101618.jgbxbk5ooiaett43@dwarf.suse.cz>
References: <20200525052351.24134-1-lijiang@redhat.com>
 <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
 <07a65a70-3764-f62f-705c-049b8d409316@redhat.com>
 <4da44e94-a839-2033-29d2-90bebd4ee1e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da44e94-a839-2033-29d2-90bebd4ee1e2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:08:12PM +0800, lijiang wrote:
> Or the following change looks better? What's your opinion?
> 
> static int
> kimage_validate_signature(struct kimage *image)
> {
>         int ret;
> 
>         ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>                                            image->kernel_buf_len);
>         if (ret) {
> 
>                 if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>                         pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
>                         return ret;
>                 }
> 
>                 /*
>                  * If IMA is guaranteed to appraise a signature on the kexec
>                  * image, permit it even if the kernel is otherwise locked
>                  * down.
>                  */
>                 if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
>                     security_locked_down(LOCKDOWN_KEXEC))
>                         return -EPERM;
> 
>                 pr_debug("kernel signature verification failed (%d).\n", ret);
>         }
> 
>         return 0;
> }

Looks good to me, thanks!

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

