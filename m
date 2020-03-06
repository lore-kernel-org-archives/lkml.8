Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48292C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5A206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opXbUk28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFVJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:09:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44907 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFVJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:09:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id a10so3649014ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgTxqzB2ddlD/i+D2EmIl9SHrUIZn4MxN31KBo15UKk=;
        b=opXbUk28LqpuR5n8R9xiecRy0l13TCDjYEZkLAgwhP6/yN8WPPtvMCwHvy3otOssah
         GuZahCDENlbFGlY1DAyrHXCqltOfx6qqoj3tRdtzc+W+7aYPrbDSncymDuhC+tSiEemr
         pCpt5kGO892XdSiNyoDRStsIPeR0qPVcEtoMuNhzLwRHxXR+/fZ0WNKprHkkQpJQdy9t
         t5tzwRRSBh0nnDtEiaRhvwI2mDSxEedQ4isLAJQ3ofEoGqT3LJEPIujXg4J61iq5hOGY
         1R0jzt45Nd/GGvjNfw8qttfm5oTWJk4zhvi07T5ccNNFFr5+JrIdoagVeL//K1Qx/heB
         Vm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgTxqzB2ddlD/i+D2EmIl9SHrUIZn4MxN31KBo15UKk=;
        b=cxHWGaccGgwTYtdTNJxP9m3oAVR/MMG1AjL/0tB9J2EcApNg59Aad5j8tKMJdrgzae
         pLGzXm0tn42YMLeFyHNVRvc4z7mT2sr1YZtCrrWbZDotPsYpRnxPwcMAwvlAmz1aQ+mB
         Kt89nZnuPuVcRmeRt3RDsCZdOi2Ibjl2hnO0aCazzJJ1oDThbNuwHSvSn2cpV9W4kN53
         0fE3nV7Lulu55F5IoKVLUMpM9JPY6LKPgAypyP7L47FFz9B8pcf/OtIu77Pl+1eKnOLu
         URQ/z/Ed4kOdohwL9ibicvZvzKXB7vnzH1Inrgjt1C2HHaJtm8rhHJAYmnF+N/Iac6Gd
         YMdA==
X-Gm-Message-State: ANhLgQ3FEpxv/N4QJOz5WX1Vi1f8RXyxCaHQfgDvdXb6kcV/CwHH79cT
        h6FIfYd6EpQnsv5D8wcQAInBZCWIOZhFycap5MLnM7Si
X-Google-Smtp-Source: ADFU+vu0OX7N8vmMOZJ3kUsbGbbpzTQXOUdf+fFe7/DRFNX6P7sDOrBZkzuDpJLbWd5dLKqbioR6dNmdrzdHWRXlcVo=
X-Received: by 2002:a2e:8015:: with SMTP id j21mr3093402ljg.194.1583528997442;
 Fri, 06 Mar 2020 13:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20191229070419.5429-1-tiny.windzz@gmail.com>
In-Reply-To: <20191229070419.5429-1-tiny.windzz@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 Mar 2020 22:09:46 +0100
Message-ID: <CANiq72k2Dy5a4NtCmCQeCt=iVB6JjftuQizy69vMW5RCcD3uCg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: img-ascii-lcd: convert to devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     paulburton@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Sun, Dec 29, 2019 at 8:04 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Thanks! Picking it up.

Cheers,
Miguel
