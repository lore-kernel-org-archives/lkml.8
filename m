Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33724C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044DB2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyKyuTKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgANJHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:07:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51649 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgANJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578992866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLFnYP8rZuEnfnaJL3rq9IwFEwWNuaUrudw5TYNZZzQ=;
        b=MyKyuTKSIimBGmsU62jj3uefgHRJIwr95Plp7HkuTOuEYvpfSeTlsHA35ae7iUZYvaeG1s
        TE4GaCGmOO4ug2k3gsAQQ+vFoMjQGspVgvQ60hMFiKdxc0hGcD1IW9tRd/691DqPoX5tZR
        GZh2WR6fcN9Q+Kek7mExpIT+ef8+5KI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-XI0tuqH3OFahxVy2CdH3Gg-1; Tue, 14 Jan 2020 04:07:44 -0500
X-MC-Unique: XI0tuqH3OFahxVy2CdH3Gg-1
Received: by mail-wm1-f71.google.com with SMTP id b9so3299264wmj.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aLFnYP8rZuEnfnaJL3rq9IwFEwWNuaUrudw5TYNZZzQ=;
        b=WVIukWY3TWOxt20jBTeDYFj+muL6RbG2jG8odZt2oxtaES2TL9a/aPmmGrnShetwG9
         0v8RPDqhUnkGTwAtRbLWgJFL2PsB1nUkF1lFK27PRuVKO20n75vIHt++tiUcH1veAgdG
         TzacExx9gnhJCi9kaa3TXeBJgXaxjhRPCaRaFOlRH57tPqikMNUQ3tnYZ34a1u50kOcn
         sFGpTsjT51iVmQ2L2JM51beSt/x2gtq9GalBr5RnY6/ZcEGkR6Oik91BsrWF7apAgkev
         1udIXcKlmEV5e5cjTjU1V8qPnplb9fCKCK55SRHUaV86/dAv9S00KezQsjbGP18M8CeL
         zYBw==
X-Gm-Message-State: APjAAAVl5F+epmYukuS5lqZd9ePe0/L82hDDqVMjcbapbfjdxASaoKJc
        gGYnQ0s9NXIxO9qfSm86Xyyq76FJ8+x0e1fuXQP4GHVmB7yMdusIqSa+hE3+uowWkSHPoEMDrIF
        4Hbo0nOc9O8X1VTpcfthUjknX
X-Received: by 2002:a5d:6151:: with SMTP id y17mr23029140wrt.110.1578992863675;
        Tue, 14 Jan 2020 01:07:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyticYHbd0lvdqSRmgWirb8Z584H59+dRskdZoKh5DUAd/tCDgi1oL7WWR+bD+oBaj/VEQiUA==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr23029117wrt.110.1578992863453;
        Tue, 14 Jan 2020 01:07:43 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id w19sm17296005wmc.22.2020.01.14.01.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 01:07:42 -0800 (PST)
Subject: Re: [PATCH 3/3] Input: axp20x-pek - Enable wakeup for all AXP
 variants
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20200113032032.38709-1-samuel@sholland.org>
 <20200113032032.38709-3-samuel@sholland.org> <20200113212654.GA47797@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <df608e7c-a0bd-5077-c8e4-db661353e076@redhat.com>
Date:   Tue, 14 Jan 2020 10:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113212654.GA47797@dtor-ws>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-01-2020 22:26, Dmitry Torokhov wrote:
> Hi Samuel,
> 
> On Sun, Jan 12, 2020 at 09:20:32PM -0600, Samuel Holland wrote:
>> There are many devices, including several mobile battery-powered
>> devices, using other AXP variants as their PMIC. Enable them to use
>> the power key as a wakeup source.
> 
> Are these X86 or ARM devices? If anything, I'd prefer individual drivers
> not declare themselves as wakeup sources unconditionally. With devic
> etree we have standard "wakeup-source" property, but I am not quite sure
> what's the latest on X86...

The AXP288 variant is X86, the other PMIC models are for ARM
(to the best of my knowledge).

Regards,

Hans

