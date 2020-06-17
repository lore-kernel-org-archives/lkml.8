Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1B321897
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8L/mum3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgFQWDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgFQWDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:03:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ECDC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:03:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so1604493pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FxWBzqH20Ldut/ncbfepnMWFG7FF0MXXG+/ZQ1Q/k20=;
        b=Q8L/mum3I/Hjh9d+oNtQ/w09JtOl4ahKeV0h2TqgLkmhSyQ0mUf4EwhseOmSA3Kt47
         oRGdFqyRqOS3w00z7fjchxraFVbvK5caeXqNwRhwaZbR5lKuA6XMnx3BGvZ/91G9e5BW
         r7WpLacvYI3YIeR1zbACg4BQtwVGgMhWTN0r3h/wiFJcHKPNep8SgrvjOfin44XQXoxx
         Ngw9EcQ3/Jp/u7dp+kYjK6SH3I8kKCb7zKvZm4Hwh98+zX1MjAIBVbNUsvDKeSI2vlvY
         +lbfI7/eNNJklE+c2SOgIw/nfyE/seqM40xxsiwi/VPpCZF06UjdDzI3F5d9xxL4hAGi
         GGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FxWBzqH20Ldut/ncbfepnMWFG7FF0MXXG+/ZQ1Q/k20=;
        b=iSOTJfokol7uVRywBv4vfJU9g2xVaj4ThANrSlM324Wx1TaQAj5J3AScEqtDBcqGZe
         yohOoUetABbqU++n0VomedpCArph9Kmf7gztbjduiLbLToiuaLuR5uZs+xtWS0eUc+1o
         3NCPvrNGvtpCmHTWETsBIZxJdrRZM3V/a96X1/37ecRjo6b7KuxYjtbpqmyJiUGJg7fo
         s7K2gRB/umTYGMnJg+ySvRqFxCfOFEogS//ojODjON2kVic/AVy2N5b6W1TXMpwufq4R
         2V+3K4amuea1CndCZM39Ni//R+3D4ErzvfYURMhc0glETXg+gERa1F/gGEM7XZ96czYR
         P4FQ==
X-Gm-Message-State: AOAM53029FSM6eo78e7XDxnHOnU5PMI+eVaEJNXJXckwZ2+X2WSCiWhI
        UxKCLIc4N1EvzMBLTDKqlhM=
X-Google-Smtp-Source: ABdhPJytA/fm6+Sl/XlT8Ovsoq9qBn/cy71kg2hsfEpLahwJljbs66yJm9Fn8uiKl5Pw8GYrfcQgSA==
X-Received: by 2002:a17:90a:b384:: with SMTP id e4mr1049797pjr.1.1592431424672;
        Wed, 17 Jun 2020 15:03:44 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j6sm745499pfi.183.2020.06.17.15.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 15:03:43 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] bcm2835-drivers-fixes-2020-0-17
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200617111453.23345-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7979468c-3781-ea2f-ec36-1f949a14e807@gmail.com>
Date:   Wed, 17 Jun 2020 15:03:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617111453.23345-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2020 4:14 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-drivers-fixes-2020-0-17
> 
> for you to fetch changes up to da785a87787c97823d12107a4f0ec7adcc2a78d9:
> 
>   ARM: bcm2835: Fix integer overflow in rpi_firmware_print_firmware_revision() (2020-06-17 12:51:45 +0200)
> 
> ----------------------------------------------------------------
> Fixes raspberry pi firmware version output
> 
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       ARM: bcm2835: Fix integer overflow in rpi_firmware_print_firmware_revision()

Merged into drivers/fixes, thanks!
-- 
Florian
