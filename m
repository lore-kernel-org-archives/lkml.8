Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0493C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7EC2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6t4uqKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgD3D6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgD3D6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:58:50 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB40C035494;
        Wed, 29 Apr 2020 20:58:48 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c18so31940ile.5;
        Wed, 29 Apr 2020 20:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+itFqMzz7ThWZKcLuQWzep+uBywhDgUdjtSyvWir0A=;
        b=K6t4uqKhlLiVCOvHHnfn7uZCyC9NoNl1R56rKLl3c07k3kmUAiZwjvxwt4Qnq37WF7
         VNgH3/oIiiHYRsbErGlPq2MX4f3T9V59jYn57yNqp3raQY8UYD93+7D9KP6xQjiklK+S
         Qi4FAXQibliGyxBG9BvvYRntYZRoFOW7K+VFthODpKip1kWfFSAVDMiiHuOXR3dRb3lW
         D/OxmFfMZg6PZ1xkFQX1ZmteVUKZO8Yt8C/jyoxPgaBv2ON4Qxg2j3apH6yVnjmhi7lP
         dPH8MeSGv7QcWDP2b0vInXiS21WlWazeaJMniNVqQkhOG7GgWcvlC5Tlvbdw0a63gAF5
         us9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+itFqMzz7ThWZKcLuQWzep+uBywhDgUdjtSyvWir0A=;
        b=F6pxMFf584FFuO8c3WhZcHUejF7Mle4rBZXNlG48ZuJ9bZdYXH8SwB8Ur7fXGhOO6p
         mQXAWlCXTfNk13vom1W+G7FUBHF1B9rSSRvI4kJsCf+1NFHiqE3qSH5klA/AI+/75sl/
         k2ijOJoy36DQZ0QyE8AlGHBFvWBAzSVrEryhZ05+FywBYt7PibuS30jexnByP4s5s+iI
         ks6wvnlisKdYfhZH5y4r3S0XjIHDmA+xSZcktcez6lg/WwhuiFRJEQAyBeIb3pu1fl2O
         cmVgO6tvH1/9XC2j+7COLNg3B8xnTWvSYJpZvJNb/ZFaivO9lzf1AP3bgp1pn0bIEC77
         aLrg==
X-Gm-Message-State: AGi0PuZoPjrQLcdhGDHdVKra7F4W2ovv81KbUIxsP+eVNequvEeYQxVB
        RZCDHG5hMo3y0+IDGRg8s5qr6NraA42cqfyyQA8=
X-Google-Smtp-Source: APiQypJfj+2iP12ImL8Uqdjbw9c8nGy6u7ienyamsjDBxjC1bY7xoUznZGmMTlOrrsIfe3VT2sIUeWH8r3og68HqXio=
X-Received: by 2002:a92:cece:: with SMTP id z14mr36110ilq.147.1588219128264;
 Wed, 29 Apr 2020 20:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <1588216490-60282-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1588216490-60282-1-git-send-email-zou_wei@huawei.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 30 Apr 2020 12:06:19 +0800
Message-ID: <CAAhV-H4Zh60bLLVkhZ7fJTRkBvqxiCuogHyQv-S9rC_e0+HZNw@mail.gmail.com>
Subject: Re: [PATCH -next] KVM: MIPS/VZ: Remove unneeded semicolon
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhc@lemote.com>

On Thu, Apr 30, 2020 at 11:08 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> Fixes coccicheck warnings:
>
> arch/mips/kvm/vz.c:1186:4-5: Unneeded semicolon
> arch/mips/kvm/vz.c:1195:3-4: Unneeded semicolon
> arch/mips/kvm/vz.c:1949:3-4: Unneeded semicolon
> arch/mips/kvm/vz.c:1121:2-3: Unneeded semicolon
> arch/mips/kvm/vz.c:2188:3-4: Unneeded semicolon
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  arch/mips/kvm/vz.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
> index dde2088..389dd0f 100644
> --- a/arch/mips/kvm/vz.c
> +++ b/arch/mips/kvm/vz.c
> @@ -1118,7 +1118,7 @@ static enum emulation_result kvm_vz_gpsi_cache(union mips_instruction inst,
>                 break;
>         default:
>                 break;
> -       };
> +       }
>
>         kvm_err("@ %#lx/%#lx CACHE (cache: %#x, op: %#x, base[%d]: %#lx, offset: %#x\n",
>                 curr_pc, vcpu->arch.gprs[31], cache, op, base, arch->gprs[base],
> @@ -1183,7 +1183,7 @@ static enum emulation_result kvm_trap_vz_handle_gpsi(u32 cause, u32 *opc,
>                                 trace_kvm_hwr(vcpu, KVM_TRACE_RDHWR,
>                                               KVM_TRACE_HWR(rd, sel), 0);
>                                 goto unknown;
> -                       };
> +                       }
>
>                         trace_kvm_hwr(vcpu, KVM_TRACE_RDHWR,
>                                       KVM_TRACE_HWR(rd, sel), arch->gprs[rt]);
> @@ -1192,7 +1192,7 @@ static enum emulation_result kvm_trap_vz_handle_gpsi(u32 cause, u32 *opc,
>                         break;
>                 default:
>                         goto unknown;
> -               };
> +               }
>                 break;
>  unknown:
>
> @@ -1946,7 +1946,7 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
>                 default:
>                         *v = (long)kvm_read_c0_guest_prid(cop0);
>                         break;
> -               };
> +               }
>                 break;
>         case KVM_REG_MIPS_CP0_EBASE:
>                 *v = kvm_vz_read_gc0_ebase();
> @@ -2185,7 +2185,7 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
>                 default:
>                         kvm_write_c0_guest_prid(cop0, v);
>                         break;
> -               };
> +               }
>                 break;
>         case KVM_REG_MIPS_CP0_EBASE:
>                 kvm_vz_write_gc0_ebase(v);
> --
> 2.6.2
>
