Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E249C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C392205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IIbbRosY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbgCPVNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:13:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40387 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:13:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id f3so16085969wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rA/inJ3N2dzQGtrL1M4Qr6g56ao5g6/q7NGAAMSseqI=;
        b=IIbbRosYhmoGbMSReB5jZmMjLoa7dNfhds1z14gzkwdNCqWcXtCVTdnAWdh411B9Xw
         Pf4v7dC2pqSP+PigEeewQpeiNq10Yt6zj9neGcC6dL72ZVmjZ9adFtKImkTFJN5byWrA
         YV5qo+jNI+wyc6KLos5URe77rW8L/15fw9fVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rA/inJ3N2dzQGtrL1M4Qr6g56ao5g6/q7NGAAMSseqI=;
        b=BzJgPIVdRpAzFMtnrfYW61zt6y3RMn91nnir45mgvw41KBF0pQRcCXaXXjxEDJNHsr
         +71yFG8XkW7TdRyxJoNqu1sxSI4WryClAiri4VTNeRYuWj+LDjqfHfpOCcas3RlmT+bs
         Kn7qcqJoPSzFKULw0GaTJ8WWHSr6SgMqPbvt+1xFg9SjfAFxCzZFcy42Uo2Zw3g6Vx4L
         Y2rhvaoSxS8HBmv3bmuKmFXw+7PNQnh597tDHfwEY14k6fQC3zONZnMiC1YVrG451Jym
         vumiE5iCWJrN1lwpVBFHkC0ijE7ZJ5bLU3bT1A2lPj1pyE9acklT3APsDZf9tnUlYs2M
         lbCg==
X-Gm-Message-State: ANhLgQ3u0VP6f6T9PPXEU/LoPBr0RKyfzGwL/iVkTtn+SMK6AQpx4z+G
        7yCkRKXw+aK5IC6KJsFmg0sfnYqqD//ZTw==
X-Google-Smtp-Source: ADFU+vuuSfZ5TW55YNV+T4hvZhIZ2NQ7sFNgir1TJISFKzU6o6dDmFBAVVlV4Y0u5pMnIX54CY0E7A==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr1354253wrt.102.1584393216479;
        Mon, 16 Mar 2020 14:13:36 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-114-43.cgn.fibianet.dk. [5.186.114.43])
        by smtp.gmail.com with ESMTPSA id k133sm1209338wma.11.2020.03.16.14.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 14:13:36 -0700 (PDT)
Subject: Re: [PATCH 0/6] Fix sparse warnings for common qe library code
To:     Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200312222827.17409-1-leoyang.li@nxp.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <766263cd-6b84-0c6b-d80a-d7f05fabd875@rasmusvillemoes.dk>
Date:   Mon, 16 Mar 2020 22:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312222827.17409-1-leoyang.li@nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 23.28, Li Yang wrote:
> The QE code was previously only supported on big-endian PowerPC systems
> that use the same endian as the QE device.  The endian transfer code is
> not really exercised.  Recent updates extended the QE drivers to
> little-endian ARM/ARM64 systems which makes the endian transfer really
> meaningful and hence triggered more sparse warnings for the endian
> mismatch.  Some of these endian issues are real issues that need to be
> fixed.
> 
> While at it, fixed some direct de-references of IO memory space and
> suppressed other __iomem address space mismatch issues by adding correct
> address space attributes.
> 
> Li Yang (6):
>   soc: fsl: qe: fix sparse warnings for qe.c
>   soc: fsl: qe: fix sparse warning for qe_common.c
>   soc: fsl: qe: fix sparse warnings for ucc.c
>   soc: fsl: qe: fix sparse warnings for qe_ic.c
>   soc: fsl: qe: fix sparse warnings for ucc_fast.c
>   soc: fsl: qe: fix sparse warnings for ucc_slow.c

Patches 2-5 should not change the generated code, whether LE or BE host,
as they merely add sparse annotations (please double-check with objdump
that that is indeed the case), so for those you may add

Reviewed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

I think patch 1 is also correct, but I don't have hardware to test it on
ATM. I'd like to see patch 6 split into smaller pieces, most of it seems
obviously correct.

Rasmus
