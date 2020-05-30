Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C13E20707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhfP+E6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgE3CJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgE3CJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:09:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3DC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:09:44 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r2so1405009ioo.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqDi32x6iIYDJ5ilkXExUgzGIAaBDt88sozwNWhNmdU=;
        b=RhfP+E6xLXMrOdhs7pGiXkUtf/Q2APSBbCzR7ENp2GV2Mhp7KfwjWWG5ewzaiSbaFZ
         jcPK7ztClNkm+rHICrsvvj9amcs3/0JXNcMMIpevGuLPmv2Di6ulvNDz/pnBt69KM5vI
         xUphgMdRTNzYYV1EXCoGtRVgnW9fH/TUmLrD86+ua23q1XZ4We0m+ONYM+Vh/T2SeRhF
         D9EGIYpGRGbfjuWFdyNLwSQ0dbjsatuWyaj24ZLORdAL1os4zUHV/lHvxzmSMbghmG5X
         E8n8IGK3fWKccK8dDw5l23TdC18Ex0rVE+0/Wv4vsU6o2mdxSBPVhLrqj3G6dHqhDkDk
         QYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqDi32x6iIYDJ5ilkXExUgzGIAaBDt88sozwNWhNmdU=;
        b=ehWybIuwTV5YqH6gf9vUcwtO4tbLlP/JnME+93AmUl2LDGSRvQmS4yE64NTF28lGqS
         40sQXgXgmOdH+0Q5P1NDEkYybpvf5qUTpi07YmtVhJLpDAOKdxpoJy09/Z0u7roPZ+u6
         vNSWpiwdfoj5tLJJBWq3gDoX5jPXCPt6uHoXzfFcoyBnIpipnGxOr1xqUcLlnFILkWNc
         03rWPTMLX4tji8gn6/MtrRsRMw8BBhiFcfNyJxKyv5X6WLpeItrnL1rVMNtuvPPHZeKZ
         Dd2pr80t0/0ZkHaGUtgX14V/bANwSej2dJILmW/1IDhUJsN7g4MLdIC/7zsA4o7U6gPH
         GdLA==
X-Gm-Message-State: AOAM532sV4Bn1Gi+EFXkYFi4ksb2eS77eoUrwzio+oWEjo5ElD+90AP8
        3GCi+2P5C7B3u1pgHaP7fnR5O4876fI3ODZEbAEvhQ==
X-Google-Smtp-Source: ABdhPJykXa7KkdUCgL/FbMksAxXmFiHP4XmgzhKapsn9lXwI/qbPb87Flz5ZHG3INWXxlR2pmR+O0in8fiyDOKt3Ubw=
X-Received: by 2002:a6b:e311:: with SMTP id u17mr9073494ioc.51.1590804583872;
 Fri, 29 May 2020 19:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588711355.git.ashish.kalra@amd.com> <a70e7ea40c47116339f968b7d2d2bf120f452c1e.1588711355.git.ashish.kalra@amd.com>
In-Reply-To: <a70e7ea40c47116339f968b7d2d2bf120f452c1e.1588711355.git.ashish.kalra@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Fri, 29 May 2020 19:09:08 -0700
Message-ID: <CABayD+eR7e7H_titvO6AVMK1Dv=wGLVvaTMOkhZfpAp=YQH8Sg@mail.gmail.com>
Subject: Re: [PATCH v8 18/18] KVM: SVM: Enable SEV live migration feature
 implicitly on Incoming VM(s).
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 2:22 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> For source VM, live migration feature is enabled explicitly
> when the guest is booting, for the incoming VM(s) it is implied.
> This is required for handling A->B->C->... VM migrations case.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6f69c3a47583..ba7c0ebfa1f3 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1592,6 +1592,13 @@ int svm_set_page_enc_bitmap(struct kvm *kvm,
>         if (ret)
>                 goto unlock;
>
> +       /*
> +        * For source VM, live migration feature is enabled
> +        * explicitly when the guest is booting, for the
> +        * incoming VM(s) it is implied.
> +        */
> +       sev_update_migration_flags(kvm, KVM_SEV_LIVE_MIGRATION_ENABLED);
> +
>         bitmap_copy(sev->page_enc_bmap + BIT_WORD(gfn_start), bitmap,
>                     (gfn_end - gfn_start));
>
> --
> 2.17.1
>

Reviewed-by: Steve Rutherford <srutherford@google.com>
