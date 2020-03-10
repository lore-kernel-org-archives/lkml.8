Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D698C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322B824649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHRZG4ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCJAUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:20:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44470 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgCJAUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:20:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so12070148ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hBz1qavjHeXbuuCg3AUeemYetmR3DUuVG/+d9If+VWU=;
        b=eHRZG4ulk8Cl2tUfWSOEAPjOlB0bFDo+ecXjkVSi5Hjg33rHxTEZNbbNQN6UAeZLSW
         aakIskk0QgAKKgsq2l5MhlBAv2PL43iBl3nNwdlFLqAVQHWlMRA+AYWouZqEKlplXg/c
         q19M03M/Z8VBrkpELhteux3Kd0p0ILjWnn9SnXdgr4yfAmZUp/VB1vc4hSBxcSM8nCCC
         hSRAEbHUD379PJoJvPdCVs75oW9uwFpGbTk5mQRq2Xaoyjgoe+sPgjjMWswjAXL79j9m
         Voj561zcDbsa+sSO3AouxGAEWo6mdfbQ0FMVP7WUtWZSr6HaUi0kXM+lyX5c3p3COSTm
         dasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hBz1qavjHeXbuuCg3AUeemYetmR3DUuVG/+d9If+VWU=;
        b=j57XTg6YITq64qvM135hlS7jc2a9cU8JY2nUZ+9dqo5f+2Y/v9Pjk/KZ/IBSQVK6dK
         Pix+cKiOWAL4dIxzmd+NJxM7R08sPYi/h6J3jU9qDzcsLxhWh7MQyoOae3TsH0m9aUG7
         xrdqZrbr1kawvHL5t6OyEVL4JsiSOXhflN6fzHqGy4RyUA/KEMbJn6PtIq1+MZDQeaRF
         y1x2lTggynsWVbN/8qkIp+bK/9hBjRbdJ73RHS3nL/bTZpJNFad4YendOU9dK2wAC7B6
         5/rFBlCYzKIqStsUjXAD4E1weL+ffHCah5vbRi/gGykCTJ2ab7GtrAsxC8F0niXThlDS
         dKcA==
X-Gm-Message-State: ANhLgQ3hIrRF7xv1uHQz1aQXA83Kac7vvKQdb4v0BC/GhyfmXf4Dao6K
        sPPKnbcuySIK2EALtMWBaGRFjEqEt8SNNS9bCAEywg==
X-Google-Smtp-Source: ADFU+vtW+QNYZKDazBD9NeNjXZS7T8R4yNtrHeAX9jisA3OnWnMnN8RSIyNuTXJc4XYxWYqK4Lu219OqCUBxFPshZeI=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr11185574ljk.35.1583799619557;
 Mon, 09 Mar 2020 17:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1581555616.git.ashish.kalra@amd.com> <59ca3ae4ac03c43751ce4af5119ede548bb9e8e4.1581555616.git.ashish.kalra@amd.com>
 <CABayD+f1Vk1YfpkZ7XXBpw5Z_kxzg1xb3zxtQGYaF4MbEQCT3w@mail.gmail.com>
In-Reply-To: <CABayD+f1Vk1YfpkZ7XXBpw5Z_kxzg1xb3zxtQGYaF4MbEQCT3w@mail.gmail.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Mon, 9 Mar 2020 17:19:43 -0700
Message-ID: <CABayD+eH7Cw-=na-MZv-Cf2DpXjUhjkJEGn-fbCPmqZ5Zt2uKg@mail.gmail.com>
Subject: Re: [PATCH 01/12] KVM: SVM: Add KVM_SEV SEND_START command
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
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

On Mon, Mar 9, 2020 at 2:28 PM Steve Rutherford <srutherford@google.com> wr=
ote:
>
> On Wed, Feb 12, 2020 at 5:15 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote=
:
> >
> > From: Brijesh Singh <brijesh.singh@amd.com>
> >
> > The command is used to create an outgoing SEV guest encryption context.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: x86@kernel.org
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > ---
> >  .../virt/kvm/amd-memory-encryption.rst        |  27 ++++
> >  arch/x86/kvm/svm.c                            | 125 ++++++++++++++++++
> >  include/linux/psp-sev.h                       |   8 +-
> >  include/uapi/linux/kvm.h                      |  12 ++
> >  4 files changed, 168 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documen=
tation/virt/kvm/amd-memory-encryption.rst
> > index d18c97b4e140..826911f41f3b 100644
> > --- a/Documentation/virt/kvm/amd-memory-encryption.rst
> > +++ b/Documentation/virt/kvm/amd-memory-encryption.rst
> > @@ -238,6 +238,33 @@ Returns: 0 on success, -negative on error
> >                  __u32 trans_len;
> >          };
> >
> > +10. KVM_SEV_SEND_START
> > +----------------------
> > +
> > +The KVM_SEV_SEND_START command can be used by the hypervisor to create=
 an
> > +outgoing guest encryption context.
> > +
> > +Parameters (in): struct kvm_sev_send_start
> > +
> > +Returns: 0 on success, -negative on error
> > +
> > +::
> > +        struct kvm_sev_send_start {
> > +                __u32 policy;                 /* guest policy */
> > +
> > +                __u64 pdh_cert_uaddr;         /* platform Diffie-Hellm=
an certificate */
> > +                __u32 pdh_cert_len;
> > +
> > +                __u64 plat_certs_uadr;        /* platform certificate =
chain */
> > +                __u32 plat_certs_len;
> > +
> > +                __u64 amd_certs_uaddr;        /* AMD certificate */
> > +                __u32 amd_cert_len;
> > +
> > +                __u64 session_uaddr;          /* Guest session informa=
tion */
> > +                __u32 session_len;
> > +        };
> > +
> >  References
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > index a3e32d61d60c..3a7e2cac51de 100644
> > --- a/arch/x86/kvm/svm.c
> > +++ b/arch/x86/kvm/svm.c
> > @@ -7140,6 +7140,128 @@ static int sev_launch_secret(struct kvm *kvm, s=
truct kvm_sev_cmd *argp)
> >         return ret;
> >  }
> >
> > +/* Userspace wants to query session length. */
> > +static int
> > +__sev_send_start_query_session_length(struct kvm *kvm, struct kvm_sev_=
cmd *argp,
> > +                                     struct kvm_sev_send_start *params=
)
> > +{
> > +       struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
> > +       struct sev_data_send_start *data;
> > +       int ret;
> > +
> > +       data =3D kzalloc(sizeof(*data), GFP_KERNEL_ACCOUNT);
> > +       if (data =3D=3D NULL)
> > +               return -ENOMEM;
> > +
> > +       data->handle =3D sev->handle;
> > +       ret =3D sev_issue_cmd(kvm, SEV_CMD_SEND_START, data, &argp->err=
or);
> > +
> > +       params->session_len =3D data->session_len;
> > +       if (copy_to_user((void __user *)(uintptr_t)argp->data, params,
> > +                               sizeof(struct kvm_sev_send_start)))
> > +               ret =3D -EFAULT;
> > +
> > +       kfree(data);
> > +       return ret;
> > +}
> > +
> > +static int sev_send_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
> > +{
> > +       struct kvm_sev_info *sev =3D &to_kvm_svm(kvm)->sev_info;
> > +       struct sev_data_send_start *data;
> > +       struct kvm_sev_send_start params;
> > +       void *amd_certs, *session_data;
> > +       void *pdh_cert, *plat_certs;
> > +       int ret;
> > +
> > +       if (!sev_guest(kvm))
> > +               return -ENOTTY;
> > +
> > +       if (copy_from_user(&params, (void __user *)(uintptr_t)argp->dat=
a,
> > +                               sizeof(struct kvm_sev_send_start)))
> > +               return -EFAULT;
> > +
> > +       /* if session_len is zero, userspace wants t query the session =
length */
>
> /t/to/
> >
> > +       if (!params.session_len)
> > +               return __sev_send_start_query_session_length(kvm, argp,
> > +                               &params);
> Document this behavior with the command.
>
> > +
> > +       /* some sanity checks */
> > +       if (!params.pdh_cert_uaddr || !params.pdh_cert_len ||
> > +           !params.session_uaddr || params.session_len > SEV_FW_BLOB_M=
AX_SIZE)
> > +               return -EINVAL;
> > +
> > +       /* allocate the memory to hold the session data blob */
> > +       session_data =3D kmalloc(params.session_len, GFP_KERNEL_ACCOUNT=
);
> > +       if (!session_data)
> > +               return -ENOMEM;
> > +
> > +       /* copy the certificate blobs from userspace */
> > +       pdh_cert =3D psp_copy_user_blob(params.pdh_cert_uaddr,
> > +                               params.pdh_cert_len);
> > +       if (IS_ERR(pdh_cert)) {
> > +               ret =3D PTR_ERR(pdh_cert);
> > +               goto e_free_session;
> > +       }
> > +
> > +       plat_certs =3D psp_copy_user_blob(params.plat_certs_uaddr,
> > +                               params.plat_certs_len);
> > +       if (IS_ERR(plat_certs)) {
> > +               ret =3D PTR_ERR(plat_certs);
> > +               goto e_free_pdh;
> > +       }
> > +
> > +       amd_certs =3D psp_copy_user_blob(params.amd_certs_uaddr,
> > +                               params.amd_certs_len);
> > +       if (IS_ERR(amd_certs)) {
> > +               ret =3D PTR_ERR(amd_certs);
> > +               goto e_free_plat_cert;
> > +       }
> > +
> > +       data =3D kzalloc(sizeof(*data), GFP_KERNEL_ACCOUNT);
> > +       if (data =3D=3D NULL) {
> > +               ret =3D -ENOMEM;
> > +               goto e_free_amd_cert;
> > +       }
> > +
> > +       /* populate the FW SEND_START field with system physical addres=
s */
> > +       data->pdh_cert_address =3D __psp_pa(pdh_cert);
> > +       data->pdh_cert_len =3D params.pdh_cert_len;
> > +       data->plat_certs_address =3D __psp_pa(plat_certs);
> > +       data->plat_certs_len =3D params.plat_certs_len;
> > +       data->amd_certs_address =3D __psp_pa(amd_certs);
> > +       data->amd_certs_len =3D params.amd_certs_len;
> > +       data->session_address =3D __psp_pa(session_data);
> > +       data->session_len =3D params.session_len;
> > +       data->handle =3D sev->handle;
> > +
> > +       ret =3D sev_issue_cmd(kvm, SEV_CMD_SEND_START, data, &argp->err=
or);
> sev_issue_cmd can fail. I think you want to handle those errors here
> (e.g. it can return -ebadf or a number of others). Right now they
> could get clobbered by a later copy_to_user error.
>
> It's also worth documenting what the error argp->error is filled in
> with. I didn't see anything in the docs mentioning the status codes
> (may have missed it).
>
> > +
> > +       if (copy_to_user((void __user *)(uintptr_t) params.session_uadd=
r,
> > +                       session_data, params.session_len)) {
> > +               ret =3D -EFAULT;
> > +               goto e_free;
> > +       }

One additional aspect, which also comes up for other commands, is that
it's not clear if the command succeeded if you get back -EFAULT. Any
of the copy_to_users could have failed, on either side of the
sev_issue_cmd call.

If userspace filled in the error with a reserved value (e.g.
0xFFFF0000, which is larger than the largest possible error code), it
could observe that that value was clobbered and infer that
sev_issue_cmd succeeded/failed/etc. This is particularly error prone
since the success code is zero, which is almost certainly what people
will initialize the error field as, unless they go out of their way.

I think the cleanest answer would be to write in a reserved value to
the error at the start of sev_send_* and have sev_issue_command
clobber that value with the expected value. This way, userspace can
know which GSTATE the guest transitioned to, even if it sees -EFAULT.
> > +
> > +       params.policy =3D data->policy;
> > +       params.session_len =3D data->session_len;
> > +       if (copy_to_user((void __user *)(uintptr_t)argp->data, &params,
> > +                               sizeof(struct kvm_sev_send_start)))
> > +               ret =3D -EFAULT;
> > +
> > +e_free:
> > +       kfree(data);
> > +e_free_amd_cert:
> > +       kfree(amd_certs);
> > +e_free_plat_cert:
> > +       kfree(plat_certs);
> > +e_free_pdh:
> > +       kfree(pdh_cert);
> > +e_free_session:
> > +       kfree(session_data);
> > +       return ret;
> > +}
> > +
> >  static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
> >  {
> >         struct kvm_sev_cmd sev_cmd;
> > @@ -7181,6 +7303,9 @@ static int svm_mem_enc_op(struct kvm *kvm, void _=
_user *argp)
> >         case KVM_SEV_LAUNCH_SECRET:
> >                 r =3D sev_launch_secret(kvm, &sev_cmd);
> >                 break;
> > +       case KVM_SEV_SEND_START:
> > +               r =3D sev_send_start(kvm, &sev_cmd);
> > +               break;
> >         default:
> >                 r =3D -EINVAL;
> >                 goto out;
> > diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> > index 5167bf2bfc75..9f63b9d48b63 100644
> > --- a/include/linux/psp-sev.h
> > +++ b/include/linux/psp-sev.h
> > @@ -323,11 +323,11 @@ struct sev_data_send_start {
> >         u64 pdh_cert_address;                   /* In */
> >         u32 pdh_cert_len;                       /* In */
> >         u32 reserved1;
> > -       u64 plat_cert_address;                  /* In */
> > -       u32 plat_cert_len;                      /* In */
> > +       u64 plat_certs_address;                 /* In */
> > +       u32 plat_certs_len;                     /* In */
> >         u32 reserved2;
> > -       u64 amd_cert_address;                   /* In */
> > -       u32 amd_cert_len;                       /* In */
> > +       u64 amd_certs_address;                  /* In */
> > +       u32 amd_certs_len;                      /* In */
> >         u32 reserved3;
> >         u64 session_address;                    /* In */
> >         u32 session_len;                        /* In/Out */
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 4b95f9a31a2f..17bef4c245e1 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1558,6 +1558,18 @@ struct kvm_sev_dbg {
> >         __u32 len;
> >  };
> >
> > +struct kvm_sev_send_start {
> > +       __u32 policy;
> > +       __u64 pdh_cert_uaddr;
> > +       __u32 pdh_cert_len;
> > +       __u64 plat_certs_uaddr;
> > +       __u32 plat_certs_len;
> > +       __u64 amd_certs_uaddr;
> > +       __u32 amd_certs_len;
> > +       __u64 session_uaddr;
> > +       __u32 session_len;
> > +};
> > +
> >  #define KVM_DEV_ASSIGN_ENABLE_IOMMU    (1 << 0)
> >  #define KVM_DEV_ASSIGN_PCI_2_3         (1 << 1)
> >  #define KVM_DEV_ASSIGN_MASK_INTX       (1 << 2)
> > --
> > 2.17.1
> >
>
> Looks pretty reasonable overall.
