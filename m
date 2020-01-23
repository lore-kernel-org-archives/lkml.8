Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0259C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B802253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579812638;
	bh=D4LTdBYYcqv+ik1Pg4jtD5ZnmXsEUXj8mdhQQjWTksA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UAN2B6aduW9QDZeLtV0azFVdJ68OF6giBg8spL3ev/BU098y/l0zrwESWH47QBtQu
	 nb5XUNdzQKCsrWYnxmQ4eylvsLZUOP3pUQwYQ8/0i8VljxUVVGGCbFdA5iLljTLuWz
	 hYGvTfYM2Nci1tS046eazRFn1JER6rTsn2dlAgtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAWUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgAWUuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:37 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00EB2253D;
        Thu, 23 Jan 2020 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579812636;
        bh=D4LTdBYYcqv+ik1Pg4jtD5ZnmXsEUXj8mdhQQjWTksA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TGRTjbhNsL4XA1B13RstA2PBC9UNxAAcPQ1EhwHxew8oHjyEXFb0f0NlwSjrZJj8e
         +mtBcQfwSoBGDIVvAEWOEwb7Skz706EOwFZOEe3czEJaTyJ88CHL5ENeoqWnw2jry2
         6Al5UdFzlvY1OGGjrtuoTKD0oHuNdR3MHZnbRVKk=
Received: by mail-qv1-f50.google.com with SMTP id u10so2190641qvi.2;
        Thu, 23 Jan 2020 12:50:36 -0800 (PST)
X-Gm-Message-State: APjAAAVlWOCVPhVppxNA1Oi34q9wxdj6s7TLsANSiZ3LbzsNxvevZwe8
        01APxjdcBf9LweqluOEjqdHxPteDLQBmLldSDQ==
X-Google-Smtp-Source: APXvYqyrN/ifItlATEFTfxubxslw3zMCfRZgyB5QYn1GQetklMTcxJ3km4RPXJFBnI525IWkPPS16O71YGW8tHw1uvk=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr17058351qvu.136.1579812635794;
 Thu, 23 Jan 2020 12:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20200122174005.17257-1-sravanhome@gmail.com> <CAL_JsqLq5XFdVRJa-XuTDbA_s=hpu3P4VGou=XfmSJs5NFAQqQ@mail.gmail.com>
 <3489a505-9992-037d-5007-6e5f5726a4e7@gmail.com>
In-Reply-To: <3489a505-9992-037d-5007-6e5f5726a4e7@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jan 2020 14:50:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6B76nyQ8W8LPaM7czesqN54LE=nqd_Vaz++tQ65r2PQ@mail.gmail.com>
Message-ID: <CAL_JsqJ6B76nyQ8W8LPaM7czesqN54LE=nqd_Vaz++tQ65r2PQ@mail.gmail.com>
Subject: Re: [PATCH v8] dt-bindings: regulator: add document bindings for mpq7920
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 1:14 AM saravanan sekar <sravanhome@gmail.com> wrote:
>
>
> On 22/01/20 11:16 pm, Rob Herring wrote:
>
> On Wed, Jan 22, 2020 at 11:40 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>
> Notes:
>     Changes on v8 :
>       - fixed error reported by dt_binding_check
>
> Still broken. :(
>
> Sorry I cannot reproduce any error, yaml is parsed and mps,mpq7920.example.dts is generated
>   CHKDT   Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> Please help me giving more detail

What about building the example? The build log is attached to the
patch in DT patchwork.

Rob
