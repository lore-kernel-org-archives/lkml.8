Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ED9C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A7B206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="duJ1CAR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD2QR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726774AbgD2QRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:17:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34BC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:17:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so2669056wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hC339AlYWIKjaIvmnsbzPnIvgC6f8npdAivdjP/WncE=;
        b=duJ1CAR3oC0XJTSkov4YIS7U0gdKnijRTK0zU7OF120jvwnIAqXrOiZukp76t7gqEg
         +sws3pAd0Fp715kcqIQUZ6ILybSDYsmpYBhd+d742FyzXAnETdeW6IOhAPErL4HwCrgM
         462kB+7nxNLniPCRDs6WRnbW6aa9rbAFfqsEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hC339AlYWIKjaIvmnsbzPnIvgC6f8npdAivdjP/WncE=;
        b=JFO95gnf/dD5HyG864NtdVYY/hJt+rL8kcFsh1hJqamixNQha7M4ijTP1SyVznKz3i
         ikoPmpnbGh5eT9vxG6k+3mpYel5z9uYNBKou2ApFbojfYlOB7fWi3uXf4CTSBsvRkIfM
         Od2efd2U5Vx+kx6+n7z9awkC4CGFp+tWEUI5YycNQgR6EhVLnzm7pwC09X9YOmH6hd9p
         uPrLWvmY9wjUiAUkrVQndh+55ZukPwJYTQ0Cd01WRF2nfT+OOyUV3p+QL1VbpCgEKsYa
         JT7/ErYB3noSvq0nDDy+M0Zd81BSRe6aqANnybi8CPy8mTIVOp0qNRj//7o0fGgSLYQL
         w43w==
X-Gm-Message-State: AGi0PuaofmrBO1Pb4aZafS0indtsPdLA+BZwR5hwbfwnsThAb3QEg68b
        AkW/G6vTj4S8DpsZxDL53NyfiA==
X-Google-Smtp-Source: APiQypKqSi/3QCJ/S4sT8BuxhRSzNwixocTEGZPtC0ytAcL+7Al93xW6am13M7Ws4l0ZyznfHMvcCQ==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr4139049wma.138.1588177071094;
        Wed, 29 Apr 2020 09:17:51 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id d143sm8275651wmd.16.2020.04.29.09.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:17:50 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 29 Apr 2020 18:17:47 +0200
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v9 0/8] MAC and Audit policy using eBPF (KRSI)
Message-ID: <20200429161747.GA113900@google.com>
References: <20200329004356.27286-1-kpsingh@chromium.org>
 <0165887d-e9d0-c03e-18b9-72e74a0cbd59@linux.intel.com>
 <CACYkzJ6XyHqr1W=LWV-5Z0txFBtvPCwRY-kczphy+pS7PEitqQ@mail.gmail.com>
 <b5652508-f727-b936-79b5-f8da658395f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5652508-f727-b936-79b5-f8da658395f5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I was able to reproduce the issue and also fix it (will separately
send a patch).

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..1bdd027766d4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -55,7 +55,7 @@ LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
         struct fs_context *src_sc)
-LSM_HOOK(int, 0, fs_context_parse_param, struct fs_context *fc,
+LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
         struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)

So what was happening was that:

bpf_lsm hook for fs_context_parse_param was returning 0 which led this
bit of logic to believe the parameter was parsed by the LSM.

int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter
*param)
{

[...]
        ret = security_fs_context_parse_param(fc, param);
        if (ret != -ENOPARAM)
                /* Param belongs to the LSM or is disallowed by the
                 * LSM; so
                 * don't pass to the FS.
                 */
                return ret;

        if (fc->ops->parse_param) {
                ret = fc->ops->parse_param(fc, param);
                if (ret != -ENOPARAM)
                        return ret;
        }
[...]

This resulted in the fs_context->dev_name being NULL and the following
chain to throw an -EINVAL resulting in unsuccessful mount of the root
file-system:

- do_mount_root -> do_mount -> do_new_mount -> vfs_get_tree ->
-> fc->ops->get_tree -> legacy->get_tree -> fc->fs_type->mount ->
ext4_mount -> mount_bdev -> blkdev_get_by_path -> lookup_bdev

- KP


On 29-Apr 15:45, Mikko Ylinen wrote:
> 
> 
> On 29/04/2020 15:34, KP Singh wrote:
> > Thanks for reporting this! Can you share your Kconfig please?
> 
> This is what I originally started with
> https://raw.githubusercontent.com/clearlinux-pkgs/linux-mainline/master/config
> 
> but I also tried your _LSM_ settings found in this
> https://lore.kernel.org/bpf/20200402040357.GA217889@google.com/
> 
> -- Regards, Mikko
