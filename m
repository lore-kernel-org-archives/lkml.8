Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E889CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC16206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEopgmxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDHB0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:26:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46838 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgDHB0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:26:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so5784814ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlzDmBeqdYgRXLQPAzyDPVcU/1FTfROFyX1Ur4A01Ds=;
        b=cEopgmxqQb1bo3jG7QS7u1WahFNuN0hJS0pw82KojLkmV364xeSFDSAL8hOxD3DA3S
         QprXIbjiokFPxb4uEvWRMDOcP46rydyA7y6lJh5jDBaTvW8EN+DRYmwhxBb3Ordltomd
         1MAioiDWLl7/et0Wy7l4gk26SYeNBjanGeE+Qu0XO9gVPduTPRR+k6+UU4kW/gdMoZdb
         CJ/eTc8cCR4aCSTsTyxYQdYx6gdFuTxuyzPFERgoHnfzFS+zD5tvupktXPkfcFC/TnC0
         epWsChOfvx7U/d9ecQ9MbOU7FQOCW039m4WIIEmAcRMj08OQ+PVHAHi8dynCeYhkEVvO
         kbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlzDmBeqdYgRXLQPAzyDPVcU/1FTfROFyX1Ur4A01Ds=;
        b=iCwlsMiQjLppBEDrPlyUoIiP6mxqyD7VGdsAbOT74RemdHqJy6jdTUX53rCHQdrBNr
         nMmEktwsXWHqz89xUJP5RfDp2sUpUW5qXrMmYn3Go9z5tXaNITedZvHz+7OqDXUpM5ex
         SxugA43n1KgJG1p8V/o3vcKNp2IP5lROMpVerIGsWWhdicFWqr+7uT7WLjdWHhM7URhk
         z8iujU17XfcCE3uLvgggCgZrGP7SayawIPQxooRpNwcEk2XUoh1g8o9t6AyYCveRIo9Q
         CbUoLvB7rERiPG2EgdhfamNeNy+k5y928w/0kUBZer9VFZM5QZCX32bHRXZJafACnXpU
         vSCA==
X-Gm-Message-State: AGi0PubA7o8Y3ZjQMvw6XuODF7qR2xI7LpCAQwkQ5Mdt24qF6OMQTYXk
        vJRFzuGhuf4ZCbTdJh/ogg/JlKz2shrmSageqYlFJw==
X-Google-Smtp-Source: APiQypLh65PFQiSfPPMz6ye/cSRWH3nKm8Gx7VV89Kgnd5D3lHz52QE29UFgfjWKR0+F5omc0u+faE8ytU1YVoE/2UA=
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr3276630ljj.272.1586309187964;
 Tue, 07 Apr 2020 18:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585548051.git.ashish.kalra@amd.com> <9e959ee134ad77f62c9881b8c54cd27e35055072.1585548051.git.ashish.kalra@amd.com>
 <b77a4a1e-b8ca-57a2-d849-adda91bfeac7@oracle.com> <20200403214559.GB28747@ashkalra_ubuntu_server>
 <65c09963-2027-22c1-e04d-4c8c3658b2c3@oracle.com>
In-Reply-To: <65c09963-2027-22c1-e04d-4c8c3658b2c3@oracle.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Tue, 7 Apr 2020 18:25:51 -0700
Message-ID: <CABayD+cf=Po-k7jqUQjq3AGopxk86d6bTcBhQxijnzpcUh90GA@mail.gmail.com>
Subject: Re: [PATCH v6 12/14] KVM: x86: Introduce KVM_PAGE_ENC_BITMAP_RESET ioctl
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     Ashish Kalra <ashish.kalra@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 11:53 AM Krish Sadhukhan
<krish.sadhukhan@oracle.com> wrote:
>
>
> On 4/3/20 2:45 PM, Ashish Kalra wrote:
> > On Fri, Apr 03, 2020 at 02:14:23PM -0700, Krish Sadhukhan wrote:
> >> On 3/29/20 11:23 PM, Ashish Kalra wrote:
> >>> From: Ashish Kalra <ashish.kalra@amd.com>
> >>>
> >>> This ioctl can be used by the application to reset the page
> >>> encryption bitmap managed by the KVM driver. A typical usage
> >>> for this ioctl is on VM reboot, on reboot, we must reinitialize
> >>> the bitmap.
> >>>
> >>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> >>> ---
> >>>    Documentation/virt/kvm/api.rst  | 13 +++++++++++++
> >>>    arch/x86/include/asm/kvm_host.h |  1 +
> >>>    arch/x86/kvm/svm.c              | 16 ++++++++++++++++
> >>>    arch/x86/kvm/x86.c              |  6 ++++++
> >>>    include/uapi/linux/kvm.h        |  1 +
> >>>    5 files changed, 37 insertions(+)
> >>>
> >>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> >>> index 4d1004a154f6..a11326ccc51d 100644
> >>> --- a/Documentation/virt/kvm/api.rst
> >>> +++ b/Documentation/virt/kvm/api.rst
> >>> @@ -4698,6 +4698,19 @@ During the guest live migration the outgoing guest exports its page encryption
> >>>    bitmap, the KVM_SET_PAGE_ENC_BITMAP can be used to build the page encryption
> >>>    bitmap for an incoming guest.
> >>> +4.127 KVM_PAGE_ENC_BITMAP_RESET (vm ioctl)
> >>> +-----------------------------------------
> >>> +
> >>> +:Capability: basic
> >>> +:Architectures: x86
> >>> +:Type: vm ioctl
> >>> +:Parameters: none
> >>> +:Returns: 0 on success, -1 on error
> >>> +
> >>> +The KVM_PAGE_ENC_BITMAP_RESET is used to reset the guest's page encryption
> >>> +bitmap during guest reboot and this is only done on the guest's boot vCPU.
> >>> +
> >>> +
> >>>    5. The kvm_run structure
> >>>    ========================
> >>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> >>> index d30f770aaaea..a96ef6338cd2 100644
> >>> --- a/arch/x86/include/asm/kvm_host.h
> >>> +++ b/arch/x86/include/asm/kvm_host.h
> >>> @@ -1273,6 +1273,7 @@ struct kvm_x86_ops {
> >>>                             struct kvm_page_enc_bitmap *bmap);
> >>>     int (*set_page_enc_bitmap)(struct kvm *kvm,
> >>>                             struct kvm_page_enc_bitmap *bmap);
> >>> +   int (*reset_page_enc_bitmap)(struct kvm *kvm);
> >>>    };
> >>>    struct kvm_arch_async_pf {
> >>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> >>> index 313343a43045..c99b0207a443 100644
> >>> --- a/arch/x86/kvm/svm.c
> >>> +++ b/arch/x86/kvm/svm.c
> >>> @@ -7797,6 +7797,21 @@ static int svm_set_page_enc_bitmap(struct kvm *kvm,
> >>>     return ret;
> >>>    }
> >>> +static int svm_reset_page_enc_bitmap(struct kvm *kvm)
> >>> +{
> >>> +   struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> >>> +
> >>> +   if (!sev_guest(kvm))
> >>> +           return -ENOTTY;
> >>> +
> >>> +   mutex_lock(&kvm->lock);
> >>> +   /* by default all pages should be marked encrypted */
> >>> +   if (sev->page_enc_bmap_size)
> >>> +           bitmap_fill(sev->page_enc_bmap, sev->page_enc_bmap_size);
> >>> +   mutex_unlock(&kvm->lock);
> >>> +   return 0;
> >>> +}
> >>> +
> >>>    static int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
> >>>    {
> >>>     struct kvm_sev_cmd sev_cmd;
> >>> @@ -8203,6 +8218,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
> >>>     .page_enc_status_hc = svm_page_enc_status_hc,
> >>>     .get_page_enc_bitmap = svm_get_page_enc_bitmap,
> >>>     .set_page_enc_bitmap = svm_set_page_enc_bitmap,
> >>> +   .reset_page_enc_bitmap = svm_reset_page_enc_bitmap,
> >>
> >> We don't need to initialize the intel ops to NULL ? It's not initialized in
> >> the previous patch either.
> >>
> >>>    };
> > This struct is declared as "static storage", so won't the non-initialized
> > members be 0 ?
>
>
> Correct. Although, I see that 'nested_enable_evmcs' is explicitly
> initialized. We should maintain the convention, perhaps.
>
> >
> >>>    static int __init svm_init(void)
> >>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >>> index 05e953b2ec61..2127ed937f53 100644
> >>> --- a/arch/x86/kvm/x86.c
> >>> +++ b/arch/x86/kvm/x86.c
> >>> @@ -5250,6 +5250,12 @@ long kvm_arch_vm_ioctl(struct file *filp,
> >>>                     r = kvm_x86_ops->set_page_enc_bitmap(kvm, &bitmap);
> >>>             break;
> >>>     }
> >>> +   case KVM_PAGE_ENC_BITMAP_RESET: {
> >>> +           r = -ENOTTY;
> >>> +           if (kvm_x86_ops->reset_page_enc_bitmap)
> >>> +                   r = kvm_x86_ops->reset_page_enc_bitmap(kvm);
> >>> +           break;
> >>> +   }
> >>>     default:
> >>>             r = -ENOTTY;
> >>>     }
> >>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >>> index b4b01d47e568..0884a581fc37 100644
> >>> --- a/include/uapi/linux/kvm.h
> >>> +++ b/include/uapi/linux/kvm.h
> >>> @@ -1490,6 +1490,7 @@ struct kvm_enc_region {
> >>>    #define KVM_GET_PAGE_ENC_BITMAP  _IOW(KVMIO, 0xc5, struct kvm_page_enc_bitmap)
> >>>    #define KVM_SET_PAGE_ENC_BITMAP  _IOW(KVMIO, 0xc6, struct kvm_page_enc_bitmap)
> >>> +#define KVM_PAGE_ENC_BITMAP_RESET  _IO(KVMIO, 0xc7)
> >>>    /* Secure Encrypted Virtualization command */
> >>>    enum sev_cmd_id {
> >> Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>


Doesn't this overlap with the set ioctl? Yes, obviously, you have to
copy the new value down and do a bit more work, but I don't think
resetting the bitmap is going to be the bottleneck on reboot. Seems
excessive to add another ioctl for this.
