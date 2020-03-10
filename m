Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7FCC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970F724649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjHPi4hI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCJBJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:09:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44300 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgCJBJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:09:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id i10so9407633lfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 18:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VH46Ehb61wn3Nsa+EuwV9XgSdGbIry8HRNC2P/68lZA=;
        b=rjHPi4hI9ySmdHPWP2/oYPXAfsvI7hQS1hNA1n1D8e0DkQcrAIlfGTtDtKyzW7VohF
         x5okkNCqm1mdZCnmEifVd7HToQapaHAq5jl0zPMTSDxxwsesGLmhHpehIuBLdhCPYDB5
         KVCiXQeg7q662Us88wInsQ1InY5bRPOEDRrIOMzC2meSn81EL9nW/d3BU9yP+lNA+Kma
         QERGPQPJEnwirOhBMoEpEG87bLOTU4DZRXp3LaDjSAIuDjlU1/rfXqQKwLO9o/TSAqC+
         rdc+lNawnw+f4GyFtQ5f5JFEy4rVOQBUoyQO59I0lRYNExodz/0726+bo7y93x3eYQJi
         ++Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VH46Ehb61wn3Nsa+EuwV9XgSdGbIry8HRNC2P/68lZA=;
        b=lPnKt2mzlo/y9uNYCR0VKAr6l4nhMg9NnOlXOvxC+S7LxTtTGf+K7e4E1I9GmJzzN3
         lszbZwlOWG85XSTOgmYnLj4Kqzs/+3tlSz4BocgDFuzUE1cutnZA+TsUDe+eAPpj9y8Q
         +nxwp6Kd859CJztZBuGeORKajkJ14QTDZpze9uQCAIsSmi8q7nqf9Lh6kmhs9rFiVwXS
         Y6W2dBQKLSOFw9SP/HiL0iEDBDgz9+3NWjrStyrzS1AR9JbYcup2BzmESRqUTfiCQ+Ms
         K3wTbIMDvq/b/jrVgbbuGcimb+vHY/dP2xzDbeNBeCO8K9L+2K3nn1NPV7PR+bPoYnqR
         32yw==
X-Gm-Message-State: ANhLgQ2F5Fv7AJKKfRVRsc/hFx/sgf8Q0OlCleCObjvEvKggHymIInf1
        S7HDaFfVHC9Y4zxvNqUgcBq8B3ThH1QtgMahSn226g==
X-Google-Smtp-Source: ADFU+vsJpPQRtMLbg/7hFmm1JetBjf6nVzCFU9hpVCk7A5WXVIqO+oXTsLXumVJU+m7yZeRwnJx/e0EC+8gHpl6KelA=
X-Received: by 2002:ac2:5222:: with SMTP id i2mr7811848lfl.81.1583802582314;
 Mon, 09 Mar 2020 18:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1581555616.git.ashish.kalra@amd.com> <d6f21be0c775fd51a63565c8944b03b3bf099e0f.1581555616.git.ashish.kalra@amd.com>
In-Reply-To: <d6f21be0c775fd51a63565c8944b03b3bf099e0f.1581555616.git.ashish.kalra@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Mon, 9 Mar 2020 18:09:06 -0700
Message-ID: <CABayD+dB-CQ7HwhDvkgxXne9fhy6Wbh8iQLVhEkegWhYMoLGGw@mail.gmail.com>
Subject: Re: [PATCH 03/12] KVM: SVM: Add KVM_SEV_SEND_FINISH command
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 5:16 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Brijesh Singh <brijesh.singh@amd.com>
>
> The command is used to finailize the encryption context created with
> KVM_SEV_SEND_START command.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  .../virt/kvm/amd-memory-encryption.rst        |  8 +++++++
>  arch/x86/kvm/svm.c                            | 23 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documenta=
tion/virt/kvm/amd-memory-encryption.rst
> index 0f1c3860360f..f22f09ad72bd 100644
> --- a/Documentation/virt/kvm/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/amd-memory-encryption.rst
> @@ -289,6 +289,14 @@ Returns: 0 on success, -negative on error
>                  __u32 trans_len;
>          };
>
> +12. KVM_SEV_SEND_FINISH
> +------------------------
> +
> +After completion of the migration flow, the KVM_SEV_SEND_FINISH command =
can be
> +issued by the hypervisor to delete the encryption context.
> +
> +Returns: 0 on success, -negative on error
> +
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index ae97f774e979..c55c1865f9e0 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -7387,6 +7387,26 @@ static int sev_send_update_data(struct kvm *kvm, s=
truct kvm_sev_cmd *argp)
>         return ret;
>  }
>
> +static int sev_send_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +       struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
> +       struct sev_data_send_finish *data;
> +       int ret;
> +
> +       if (!sev_guest(kvm))
> +               return -ENOTTY;
> +
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->handle =3D sev->handle;
> +       ret =3D sev_issue_cmd(kvm, SEV_CMD_SEND_FINISH, data, &argp->erro=
r);
> +
> +       kfree(data);
> +       return ret;
> +}
> +
>  static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
>  {
>         struct kvm_sev_cmd sev_cmd;
> @@ -7434,6 +7454,9 @@ static int svm_mem_enc_op(struct kvm *kvm, void __u=
ser *argp)
>         case KVM_SEV_SEND_UPDATE_DATA:
>                 r =3D sev_send_update_data(kvm, &sev_cmd);
>                 break;
> +       case KVM_SEV_SEND_FINISH:
> +               r =3D sev_send_finish(kvm, &sev_cmd);
> +               break;
>         default:
>                 r =3D -EINVAL;
>                 goto out;
> --
> 2.17.1
>
Reviewed-by: Steve Rutherford <srutherford@google.com>
