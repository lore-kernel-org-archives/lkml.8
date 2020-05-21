Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16913C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E952120721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXRwkhmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgEUNhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:37:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33708 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729465AbgEUNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590068222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9apolne3MOvgFYAOik7xpjgAh+OTAjNzLgbnviUZnk=;
        b=AXRwkhmqPkT64SYv0SbnJGSyYtwBJXtewTxpidcxm7k0j0DpL3fJqibsvALgwJ6YNw+ed7
        74ByJAX5PrdnM41W9hEK+PuXZXQb2cecVexhpFcjWTVMW27weP/VHUwMSSZYLE0MmdA365
        fpBfl7X3WaclJHav2Uf/yk6ptbxMjAA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-FJjzo88eN2W6x-WCltxcdw-1; Thu, 21 May 2020 09:36:58 -0400
X-MC-Unique: FJjzo88eN2W6x-WCltxcdw-1
Received: by mail-wm1-f69.google.com with SMTP id o8so1009402wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k9apolne3MOvgFYAOik7xpjgAh+OTAjNzLgbnviUZnk=;
        b=Gd1TigpIQ4Jtozcrl23WlwRhwQXupEKFSzBQSnZQLZR/5hLZnXtUgFmXW0lzaAeo+t
         xWeeG/AAQnBYDt9vQvDf1GCHkr3nGUAo4XnFDNsZtooNxOcD2S4fJPJ+dpNqeXwwmjmB
         g6b8DqcCPYKHxwjAJEaSpntiYM5LozYkF2YfKmrBqzds/TpIHcrL7MTMpHoo5xqAJQRB
         sg9T3+J9HU1/1Vgg0mmRHNjy93x+WGV6wO8g0zh1EEOHRdFXbOhF3fk1/K/chq8AhOxP
         xPIU0of4xfFkPRthMusv3LBz42w2MJY0AL4oC55lMkG4PLVwL9s+tlMkKaY9BqKIkvFQ
         9S7Q==
X-Gm-Message-State: AOAM533qhQGsgP+lLzHglheA8uwsXXaUMSfS6yjGFna8lak7s7QcDtQq
        qrVM+rysO9xzAcX1QTM616w4bVQc6bQpP4JZDk84yoxzL8Az0aGF8wfw81CVS5Rr0iLWGDr/nnm
        pBB+03Uyg/fcpEsBzwZ7MbWV0
X-Received: by 2002:a1c:3bc5:: with SMTP id i188mr8856755wma.90.1590068217485;
        Thu, 21 May 2020 06:36:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Qvv+LB4xFaLKN/vr1LCs4+uEau6Ef45+r3Usb72/IQMTIglg+pNLXlzEd0xvftHufcmXZQ==
X-Received: by 2002:a1c:3bc5:: with SMTP id i188mr8856739wma.90.1590068217245;
        Thu, 21 May 2020 06:36:57 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
        by smtp.gmail.com with ESMTPSA id r9sm7484013wra.52.2020.05.21.06.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 06:36:56 -0700 (PDT)
Subject: Re: [PATCH v3] kvm/x86 : Remove redundant function implement
To:     =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <HKAPR02MB4291D5926EA10B8BFE9EA0D3E0B70@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f2a3d25-adbf-26c2-4c2e-43d1a7abab97@redhat.com>
Date:   Thu, 21 May 2020 15:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <HKAPR02MB4291D5926EA10B8BFE9EA0D3E0B70@HKAPR02MB4291.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/20 07:57, 彭浩(Richard) wrote:
> pic_in_kernel(),ioapic_in_kernel() and irqchip_kernel() have the
> same implementation.
> 
> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> ---
>  arch/x86/kvm/ioapic.h  |  8 ++------
>  arch/x86/kvm/irq.h     | 14 ++++----------
>  arch/x86/kvm/lapic.c   |  1 +
>  arch/x86/kvm/mmu/mmu.c |  1 +
>  arch/x86/kvm/x86.c     |  1 +
>  5 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
> index 2fb2e3c..7a3c53b 100644
> --- a/arch/x86/kvm/ioapic.h
> +++ b/arch/x86/kvm/ioapic.h
> @@ -5,7 +5,7 @@
>  #include <linux/kvm_host.h>
> 
>  #include <kvm/iodev.h>
> -
> +#include "irq.h"
>  struct kvm;
>  struct kvm_vcpu;
> 
> @@ -108,11 +108,7 @@ do {\
> 
>  static inline int ioapic_in_kernel(struct kvm *kvm)
>  {
> -int mode = kvm->arch.irqchip_mode;
> -
> -/* Matches smp_wmb() when setting irqchip_mode */
> -smp_rmb();
> -return mode == KVM_IRQCHIP_KERNEL;
> +return irqchip_kernel(kvm);
>  }
> 
>  void kvm_rtc_eoi_tracking_restore_one(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
> index f173ab6..e133c1a 100644
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -16,7 +16,6 @@
>  #include <linux/spinlock.h>
> 
>  #include <kvm/iodev.h>
> -#include "ioapic.h"
>  #include "lapic.h"
> 
>  #define PIC_NUM_PINS 16
> @@ -66,15 +65,6 @@ void kvm_pic_destroy(struct kvm *kvm);
>  int kvm_pic_read_irq(struct kvm *kvm);
>  void kvm_pic_update_irq(struct kvm_pic *s);
> 
> -static inline int pic_in_kernel(struct kvm *kvm)
> -{
> -int mode = kvm->arch.irqchip_mode;
> -
> -/* Matches smp_wmb() when setting irqchip_mode */
> -smp_rmb();
> -return mode == KVM_IRQCHIP_KERNEL;
> -}
> -
>  static inline int irqchip_split(struct kvm *kvm)
>  {
>  int mode = kvm->arch.irqchip_mode;
> @@ -93,6 +83,10 @@ static inline int irqchip_kernel(struct kvm *kvm)
>  return mode == KVM_IRQCHIP_KERNEL;
>  }
> 
> +static inline int pic_in_kernel(struct kvm *kvm)
> +{
> +return irqchip_kernel(kvm);
> +}
>  static inline int irqchip_in_kernel(struct kvm *kvm)
>  {
>  int mode = kvm->arch.irqchip_mode;
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 9af25c9..de4d046 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -36,6 +36,7 @@
>  #include <linux/jump_label.h>
>  #include "kvm_cache_regs.h"
>  #include "irq.h"
> +#include "ioapic.h"
>  #include "trace.h"
>  #include "x86.h"
>  #include "cpuid.h"
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8071952..6133f69 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -16,6 +16,7 @@
>   */
> 
>  #include "irq.h"
> +#include "ioapic.h"
>  #include "mmu.h"
>  #include "x86.h"
>  #include "kvm_cache_regs.h"
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d786c7d..c8b62ac 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -18,6 +18,7 @@
> 
>  #include <linux/kvm_host.h>
>  #include "irq.h"
> +#include "ioapic.h"
>  #include "mmu.h"
>  #include "i8254.h"
>  #include "tss.h"
> --
> 2.7.4
> 
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人使用（包含个人及群组）。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，请立即以电子邮件通知发件人并删除本邮件及其附件。
> 
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!
> 

Queued, thanks.

Paolo

