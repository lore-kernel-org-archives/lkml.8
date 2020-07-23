Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF89EC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF01F2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595538451;
	bh=TNfGXAveyZpzu10Q7xBJu2gjN/MC2AiNzJk2+KEQCt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E4Kpr7Nh8anhp4Kw2aFWY7eiu4xVQbYB6apS7PAYxEhSs7WETS2wmIjuYun3e0/Vt
	 xqmAcsYvINjsH6y12V4+qUepFv8gJLqPhILyDycIOGt9fLw6biBKXItCqnpqAWITNn
	 0PLM2ltx3ht9jhwa6gJf9J6Scn6iHLkIMMxhu4Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGWVHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:07:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33026 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgGWVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:07:30 -0400
Received: by mail-io1-f67.google.com with SMTP id d18so7779093ion.0;
        Thu, 23 Jul 2020 14:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqiJg+iVm+KO76sfvCQ1PcB5FB3q5avv7am6yCHETiw=;
        b=IszeoXuHRUWe7GB6szpC/jmrtFHFzEqAFOwCwzEHA6jNzdc+tQtNMrQaRWxyolnAdz
         kfcr/VReUFqUQnWboe2G4tICjaBdVYdq96/mk7tulwOB0biRMUq2RkzW+46qCcmxQ8gm
         1mrxhfnoZxdN+GM6vtXHpkPEu5fd1/wk44KAN+fNuNCCuW6M1FzMVO6sDtbuUNo03en1
         lyctyo+F3blt196pkwge6GO+aRkhqGatpcyYMti5d0GmYX+/KuqWaWHrZkAsGFHQORGw
         D1qmLhHJ/yUqf6f+b9JkG0IR3lj8npjGafQKmgP7SyB6zPmJdIeBnr3u0cScdJaVrr0K
         n/kw==
X-Gm-Message-State: AOAM531+v3YckeJvePTnHoPGTvtos5p05kQd8iOnFKDF6w9XPtEcn7hz
        txfje9xMt9T346JgDEycNRY7l6g42g==
X-Google-Smtp-Source: ABdhPJw41flIcVg/c3woDitOvrf2Wnz/THl1yI2iKhN3PaLn3hSvaeMmDaHtlOtXhqqQjr/qpfOk1Q==
X-Received: by 2002:a5d:97d1:: with SMTP id k17mr6942837ios.100.1595538449560;
        Thu, 23 Jul 2020 14:07:29 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g1sm2001627ilk.51.2020.07.23.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:07:28 -0700 (PDT)
Received: (nullmailer pid 860277 invoked by uid 1000);
        Thu, 23 Jul 2020 21:07:26 -0000
Date:   Thu, 23 Jul 2020 15:07:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the
 Beelink GS-King-X
Message-ID: <20200723210726.GA860231@bogus>
References: <20200718052258.2890-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718052258.2890-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 05:22:57 +0000, Christian Hewitt wrote:
> The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
> board with an S922X-H chip.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
