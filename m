Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B294AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAFC206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="rl6LjERp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGZShC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgGZShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:37:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D30C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:37:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w126so7703547pfw.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JHh5cFzdRiiCn+biAgSR51wErCAzwQcPpQ2EoQumVdo=;
        b=rl6LjERpipRPZtBwIL7X4iy2CIPyQ9Zl+dJelxAOJONKIgwGqRBlkXFkvWZ8EwhYSM
         u516NvJ09D+EaM0yT5gUtY81dZTgiVXri+b7BUkrUxwv2/4/XNigjYoFGcVgRPu/wF82
         Kkh5vnopH8FYWb2qAomTJ9nmt6F4f2Z8srvfMtizs0z8n/Y1WV9iUH8G6uyFIV1eKkaH
         bLs//RT0quniU7FesUVGE6MazpFJwnXnTTmrMa8Bn4hZOG/+O3EZ5FPa+O0LZiYQLaYL
         nQJdWp34qygYaribmhcIPKTsJNIDyO2gm1VCn0hr1F6IuXQrNz2d9Ao9UllbMhiyHnuq
         cVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JHh5cFzdRiiCn+biAgSR51wErCAzwQcPpQ2EoQumVdo=;
        b=k0BvJi+xNsGAsiVRqS2uWl5hHx4a+o6cfUmCCkhIWcDFc/cpC0dVxXc07wCHxs/MrJ
         0/dA3HXHqG2yz6SnQgJ2Jkdo3NaVNkh8e902M9maB87dkFX18g5DZBJRaVBq8rYkYcNX
         Ig24Hmj05rJ5/QE4r2isuVWwkp64lcUVpfiKnlJSKY8B6XRMzuaqgGi6SEE+ufLqnCCG
         EzXyUtU+0YML+LBjQ8otXwWBV2UL7DRRdataytRx5trnN76Wp0pa7l2+TbM1DWm+i63j
         2oVevT/J47IU5tE7de2VaDcg3Dmq18SxwA8Telb25yGJgINzT7fJ6P1+LKPJSJ1g+nyf
         NItg==
X-Gm-Message-State: AOAM531E/Zm7uQorNGEz9EzP3qZBOUuLc3EHXES2EaPRBrpuU5ISDSXM
        L6WpFPOrFDNXN9ah83ussEPhtQ==
X-Google-Smtp-Source: ABdhPJwZi7YuLtKvHHHpTUUiFWqFIbWskKh6Eje8v+OZ3A5rX35gIG8XYiFjYgjx1VL/wj+izccBew==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr17384523pgv.213.1595788620755;
        Sun, 26 Jul 2020 11:37:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k63sm12740008pge.0.2020.07.26.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 11:37:00 -0700 (PDT)
Date:   Sun, 26 Jul 2020 11:37:00 -0700 (PDT)
X-Google-Original-Date: Sun, 26 Jul 2020 11:36:53 PDT (-0700)
Subject:     Re: [PATCH v4 4/4] dt-bindings: timer: Add CLINT bindings
In-Reply-To: <CAAhSdy1Dx+oP0guRGvCFa61gL93R+pcQDYLdMpo+LaOjA5tvBQ@mail.gmail.com>
CC:     atishp@atishpatra.org, devicetree@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        daniel.lezcano@linaro.org, kernel@esmil.dk,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org, seanga2@gmail.com
Message-ID: <mhng-5833da8b-f9df-46c4-8dbe-0240e39d7bc5@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 20:55:31 PDT (-0700), anup@brainfault.org wrote:
> On Tue, Jul 21, 2020 at 5:48 PM Sean Anderson <seanga2@gmail.com> wrote:
>>
>> On 7/20/20 9:15 PM, Atish Patra wrote:
>> > On Fri, Jul 17, 2020 at 12:52 AM Anup Patel <anup.patel@wdc.com> wrote:
>> >>
>> >> We add DT bindings documentation for CLINT device.
>> >>
>> >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> >> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> >> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
>> >> ---
>> >>  .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
>> >>  1 file changed, 58 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> >> new file mode 100644
>> >> index 000000000000..8ad115611860
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>> >> @@ -0,0 +1,58 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/timer/sifive,clint.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: SiFive Core Local Interruptor
>> >> +
>> >> +maintainers:
>> >> +  - Palmer Dabbelt <palmer@dabbelt.com>
>> >> +  - Anup Patel <anup.patel@wdc.com>
>> >> +
>> >> +description:
>> >> +  SiFive (and other RISC-V) SOCs include an implementation of the SiFive
>> >> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
>> >> +  interrupts. It directly connects to the timer and inter-processor interrupt
>> >> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
>> >> +  interrupt controller is the parent interrupt controller for CLINT device.
>> >> +  The clock frequency of CLINT is specified via "timebase-frequency" DT
>> >> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
>> >> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    items:
>> >> +      - const: sifive,clint0
>> >> +      - const: sifive,fu540-c000-clint
>> >> +
>> >> +    description:
>> >> +      Should be "sifive,<chip>-clint" and "sifive,clint<version>".
>> >> +      Supported compatible strings are -
>> >> +      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
>> >> +      onto the SiFive FU540 chip, and "sifive,clint0" for the SiFive
>> >> +      CLINT v0 IP block with no chip integration tweaks.
>> >> +      Please refer to sifive-blocks-ip-versioning.txt for details
>> >> +
>> >
>> > As the DT binding suggests that the clint device should be named as "sifive,**",
>> > I think we should change the DT property in kendryte dts as well.
>>
>> The kendryte device is based on Rocket Chip, not any SiFive IP/device.
>> If anything, the general binding should be "chipsalliance,clint" and the
>> specific bindings should be "sifive,clint" and "kendryte,clint" (or
>> "canaan,clint").
>
> AFAIK, Palmer clearly mentioned in previous discussion that CLINT
> spec is still owned by SiFive. No matter who implements CLINT device
> in their SOC, we will need one compatible string to represent the
> spec version (i.e. "sifive,clint0") and another compatible representing
> specific implementation (for kendryte this can be "kendryte,k210-clint").

I think "sifive,clint*" is the way to go here.  The Free Chips Foundation owns
Rocket Chip, which contains an implementation of SiFive's CLINT specification,
but as far as I can tell Free Chips itself does not produce a specification for
the CLINT.  The only CLINT specifications I can find are for SiFive's chips and
are copyright SiFive, and we generally prefer sticking to specifications rather
than implementations for these sorts of things.

To be honest, I'm not even sure the Free Chips CLINT is an implementation of
the SiFive specification: we don't have the source code for those chips, and
while I'm fairly sure the Chisel source code for the CLINT itself on SiFive's
chips is very close to what was in Rocket Chip at the time those chips were
built (though we don't have the source, so we don't know for user), device
specifications depend on the broader SOC context they are embedded inside.  For
example: SiFive's CLINT allows us to use simple MMIO reads of mtime to meet the
RISC-V rdtime requirements, but other bus configurations may not meet those
requirement<F6><F5>s.

If Free Chips publishes a specification for a CLINT and it's compatible with
this version of SiFive's CLINT then I don't see any reason why we couldn't add
that as a compatible string, but as it currently stands there is no Free Chips
CLINT specification.  IMO it would be irresponsible for us to define one on
their behalf.

I don't know anything about Kendryte's specifications, as I haven't read them
myself.  Assuming they define the CLINT's behavior in their SOC manual, then
adding something along the lines of "canaan,kendryte-k210-clint" seems
reasonable to me -- don't really care that much about the specific name, but as
we don't define the Kendryte SOCs then calling it anything more general than
this specific SOC's CLINT seems unreasonable.  AFAIK the Kendryte people don't
get involved with Linux development directly, so that's probably as much as we
can define.
