Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwuNnstT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgBLErO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:47:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45549 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgBLErO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:47:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so497472wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 20:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AJFwf208ztjD3VSB6UihW2iIA2TERTYV2qKImF8NJlg=;
        b=jwuNnstTrRtBlI0XBteLISHOd1hYhgEi6Nmov2YvNW5SqCv9rPedJCWqU6JFS1QKLE
         EyIO34p70P5NY+1psCYazRiyopTmy7LRG5fMAtbB9aHX1Mi1k7dFMquvfB8Au8vyQozd
         oTMhb2fM6StgOsGw7e3xY5Uvxs74a9d/lgEo6NZqSx2D/Fo5PcSebGxcAKbhPsMI54ZM
         ypn/Nc6tabJR9ZAXoVaxEWcYQbxJ74EmpKYHzhj22L0pvKjdbLsNg/pAKSnBPEfKQO00
         d1clkKO7U6W/i1MqTxIuo4fvSTQCuRsx2hA1g5C0Z3hjOHKReA1hz6I2hmu4BDj6FBEQ
         KnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AJFwf208ztjD3VSB6UihW2iIA2TERTYV2qKImF8NJlg=;
        b=pnyDLrfo7ksqIOVLFSf54HiTCovsTIrjedMc0kPr1vpA7pEoAbZ/NpbkLB7vvJpw+H
         17gvH8V1Z7H0X87w7KLCnKB7mhFEpv3Lkk0VlA47EDoGPolU4LvjFB4PgH+5lqJJw/t1
         JZhYxbf+oy5+gRenvG///oAJ3r3dMMo8nbcI6Pk5r1CfFWnu8Ww/kirl0042Xm50Jnao
         by87RhBRQzIuDqsw40lF7UIJDGVbI08iIC1G6otrk1T8tMuuADPsp8tYVFcwW2NJQBwX
         42rzzSBKJhDOnzT5d8eqEcKHQYtDcmBeG4zoNJIP3H060VXoScb9ZqP3bcLIz6tRGgSu
         lNjw==
X-Gm-Message-State: APjAAAVsit7bKHT9M3cI8KdvfahFIbem8mgmEgh+o7yGAyIxmTlBicna
        u1go74AK+/Bc1N2NClutx91xMDbO
X-Google-Smtp-Source: APXvYqxL3k34J6wQGIU8YM9nnqG5ErV7ZQ4E5CCftinbKt+/A+upvX2KqokuDNf0cT3WtHywpBMByw==
X-Received: by 2002:adf:e543:: with SMTP id z3mr12335684wrm.369.1581482831758;
        Tue, 11 Feb 2020 20:47:11 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id n3sm6826142wmc.27.2020.02.11.20.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 20:47:10 -0800 (PST)
Subject: Re: [PATCH v2] irqchip/bcm2835: Quiesce IRQs left enabled by
 bootloader
To:     Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Schneider <serge@raspberrypi.org>,
        Kristina Brooks <notstina@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
References: <713627a200d9c8fd7cac424d69e98166@kernel.org>
 <8be2f3e95fb29abdf80240f2b8a38621c42eb2a9.1581327911.git.lukas@wunner.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 mQGiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz7QnRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+iGYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSC5BA0ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU4hPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJ7kCDQRXG8fwARAA6q/pqBi5PjHcOAUgk2/2LR5LjjesK50bCaD4JuNc
 YDhFR7Vs108diBtsho3w8WRd9viOqDrhLJTroVckkk74OY8r+3t1E0Dd4wHWHQZsAeUvOwDM
 PQMqTUBFuMi6ydzTZpFA2wBR9x6ofl8Ax+zaGBcFrRlQnhsuXLnM1uuvS39+pmzIjasZBP2H
 UPk5ifigXcpelKmj6iskP3c8QN6x6GjUSmYx+xUfs/GNVSU1XOZn61wgPDbgINJd/THGdqiO
 iJxCLuTMqlSsmh1+E1dSdfYkCb93R/0ZHvMKWlAx7MnaFgBfsG8FqNtZu3PCLfizyVYYjXbV
 WO1A23riZKqwrSJAATo5iTS65BuYxrFsFNPrf7TitM8E76BEBZk0OZBvZxMuOs6Z1qI8YKVK
 UrHVGFq3NbuPWCdRul9SX3VfOunr9Gv0GABnJ0ET+K7nspax0xqq7zgnM71QEaiaH17IFYGS
 sG34V7Wo3vyQzsk7qLf9Ajno0DhJ+VX43g8+AjxOMNVrGCt9RNXSBVpyv2AMTlWCdJ5KI6V4
 KEzWM4HJm7QlNKE6RPoBxJVbSQLPd9St3h7mxLcne4l7NK9eNgNnneT7QZL8fL//s9K8Ns1W
 t60uQNYvbhKDG7+/yLcmJgjF74XkGvxCmTA1rW2bsUriM533nG9gAOUFQjURkwI8jvMAEQEA
 AYkCaAQYEQIACQUCVxvH8AIbAgIpCRBhV5kVtWN2DsFdIAQZAQIABgUCVxvH8AAKCRCH0Jac
 RAcHBIkHD/9nmfog7X2ZXMzL9ktT++7x+W/QBrSTCTmq8PK+69+INN1ZDOrY8uz6htfTLV9+
 e2W6G8/7zIvODuHk7r+yQ585XbplgP0V5Xc8iBHdBgXbqnY5zBrcH+Q/oQ2STalEvaGHqNoD
 UGyLQ/fiKoLZTPMur57Fy1c9rTuKiSdMgnT0FPfWVDfpR2Ds0gpqWePlRuRGOoCln5GnREA/
 2MW2rWf+CO9kbIR+66j8b4RUJqIK3dWn9xbENh/aqxfonGTCZQ2zC4sLd25DQA4w1itPo+f5
 V/SQxuhnlQkTOCdJ7b/mby/pNRz1lsLkjnXueLILj7gNjwTabZXYtL16z24qkDTI1x3g98R/
 xunb3/fQwR8FY5/zRvXJq5us/nLvIvOmVwZFkwXc+AF+LSIajqQz9XbXeIP/BDjlBNXRZNdo
 dVuSU51ENcMcilPr2EUnqEAqeczsCGpnvRCLfVQeSZr2L9N4svNhhfPOEscYhhpHTh0VPyxI
 pPBNKq+byuYPMyk3nj814NKhImK0O4gTyCK9b+gZAVvQcYAXvSouCnTZeJRrNHJFTgTgu6E0
 caxTGgc5zzQHeX67eMzrGomG3ZnIxmd1sAbgvJUDaD2GrYlulfwGWwWyTNbWRvMighVdPkSF
 6XFgQaosWxkV0OELLy2N485YrTr2Uq64VKyxpncLh50e2RnyAJ9qfUATKC9NgZjRvBztfqy4
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <fb9ce391-e217-1207-d3b7-0a69b7ab3837@gmail.com>
Date:   Tue, 11 Feb 2020 20:47:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <8be2f3e95fb29abdf80240f2b8a38621c42eb2a9.1581327911.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2020 1:52 AM, Lukas Wunner wrote:
> Customers of our "Revolution Pi" open source PLCs (which are based on
> the Raspberry Pi) have reported random lockups as well as jittery eMMC,
> UART and SPI latency.  We were able to reproduce the lockups in our lab
> and hooked up a JTAG debugger:
> 
> It turns out that the USB controller's interrupt is already enabled when
> the kernel boots.  All interrupts are disabled when the chip comes out
> of power-on reset, according to the spec.  So apparently the bootloader
> enables the interrupt but neglects to disable it before handing over
> control to the kernel.
> 
> The bootloader is a closed source blob provided by the Raspberry Pi
> Foundation.  Development of an alternative open source bootloader was
> begun by Kristina Brooks but it's not fully functional yet.  Usage of
> the blob is thus without alternative for the time being.
> 
> The Raspberry Pi Foundation's downstream kernel has a performance-
> optimized USB driver (which we use on our Revolution Pi products).
> The driver takes advantage of the FIQ fast interrupt.  Because the
> regular USB interrupt was left enabled by the bootloader, both the
> FIQ and the normal interrupt is enabled once the USB driver probes.
> 
> The spec has the following to say on simultaneously enabling the FIQ
> and the normal interrupt of a peripheral:
> 
> "One interrupt source can be selected to be connected to the ARM FIQ
>  input.  An interrupt which is selected as FIQ should have its normal
>  interrupt enable bit cleared.  Otherwise a normal and an FIQ interrupt
>  will be fired at the same time.  Not a good idea!"
>                                   ^^^^^^^^^^^^^^^
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> page 110
> 
> On a multicore Raspberry Pi, the Foundation's kernel routes all normal
> interrupts to CPU 0 and the FIQ to CPU 1.  Because both the FIQ and the
> normal interrupt is enabled, a USB interrupt causes CPU 0 to spin in
> bcm2836_chained_handle_irq() until the FIQ on CPU 1 has cleared it.
> Interrupts with a lower priority than USB are starved as long.
> 
> That explains the jittery eMMC, UART and SPI latency:  On one occasion
> I've seen CPU 0 blocked for no less than 2.9 msec.  Basically,
> everything not USB takes a performance hit:  Whereas eMMC throughput
> on a Compute Module 3 remains relatively constant at 23.5 MB/s with
> this commit, it irregularly dips to 23.0 MB/s without this commit.
> 
> The lockups occur when CPU 0 receives a USB interrupt while holding a
> lock which CPU 1 is trying to acquire while the FIQ is temporarily
> disabled on CPU 1.
> 
> I've tested old releases of the Foundation's bootloader as far back as
> 1.20160202-1 and they all leave the USB interrupt enabled.  Still older
> releases fail to boot a contemporary kernel on a Compute Module 1 or 3,
> which are the only Raspberry Pi variants I have at my disposal for
> testing.
> 
> Fix by disabling IRQs left enabled by the bootloader.  Although the
> impact is most pronounced on the Foundation's downstream kernel,
> it seems prudent to apply the fix to the upstream kernel to guard
> against such mistakes in any present and future bootloader.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Serge Schneider <serge@raspberrypi.org>
> Cc: Kristina Brooks <notstina@gmail.com>
> Cc: stable@vger.kernel.org

It would be nice to provide a Fixes: tag so it gets backported to the
relevant -stable trees, this may be dating back to the first time the
driver was brought in tree. The commit message is a bit long and starts
going into details that I am not sure add anything, but FWIW:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
