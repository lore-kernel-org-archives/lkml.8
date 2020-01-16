Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559EBC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261FF222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHvGxNYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAPC2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:28:13 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43013 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAPC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:28:12 -0500
Received: by mail-yb1-f194.google.com with SMTP id k15so3889183ybd.10;
        Wed, 15 Jan 2020 18:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwQsFePft3MfAfTwN78fKEDrEk3xpT6VkZlinejpxg8=;
        b=eHvGxNYjkklmWwDAF0QtjAfJ0ddV5IbvTQmBmdI8EAMRg48lNG1u019SMzE0mJlGAz
         95n8fNW/9/oAV6yYv6wPThFbTJ+f2826FSYvtqQ19HeRQfFqG0Xn9zsdPAZO9Y36XzFZ
         GCr5vz918v/S90GwjGBGYwHx07RUTeZUk0qXZTKrgZKl+3ZZNAU/VM5CTVVRSDHxjW23
         gZbeJp7HECVH7LCMnzgjt7uoMMNa0GUu3pLRtfhc3NTwaNmmNQ/AqfiJAYbGzdVadQFD
         HmTzKx9uGHhOdLVXA+k57KMmGBD7y2sdd+q+76j9cCPsCRTNYpyJIX3z5kprP1WZV7Y5
         PE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwQsFePft3MfAfTwN78fKEDrEk3xpT6VkZlinejpxg8=;
        b=plfuW1OokFYegOVXm7fKOb8t/7TvkKPO03aEkDIRZXwG+lKmf7SSd4phfmkC9tB2+n
         DuXBAZSynI37RUFCyzxOHHf4sNOzqVGz7dhAfPCuIs9gFBUjgDXoHX/zOA2YMH0ligGE
         JISndXfOAGFLoalQwosyAhMqmBNNcU+Rt4QVN6/Vwiynj3URjOUBGyKqt47hB75psKYO
         6ixmSCVMQq9tcWhu88B8gTG6ISYM1J/sBTs04V0mE96wX03mYmvXfsunJaUFXNU2nTt1
         XO80iXSZh3zqB6MfvL2xhLMCe2KW6zD4vxJGK8+gV1SEUZHEWw/JSTIEIw6yFWVaPVhJ
         9qKQ==
X-Gm-Message-State: APjAAAWWHceIpvHA4s5V6KKJ/hqsRQUcUrMAKLgug/+EiuhM384YxN84
        gJg8NN4Wv+7eNV/Nq4ekjqU=
X-Google-Smtp-Source: APXvYqxXKXxVNGaAMW2cQS8aucaHhLtqF3hShj71i8iQx2Pa6JsI4eab9wqzgth1S0qy77qcHwC8yA==
X-Received: by 2002:a25:e00c:: with SMTP id x12mr2216572ybg.224.1579141691642;
        Wed, 15 Jan 2020 18:28:11 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id y66sm9038746ywf.79.2020.01.15.18.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 18:28:11 -0800 (PST)
Subject: Re: [RFC PATCH 0/3] Add device tree build information
To:     Alexandre Torgue <alexandre.torgue@st.com>, robh+dt@kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        david@gibson.dropbear.id.au, sjg@chromium.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, devicetree-compiler@vger.kernel.org
References: <20200113181625.3130-1-alexandre.torgue@st.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f21ad44d-f119-2035-b4ee-16b3619879af@gmail.com>
Date:   Wed, 15 Jan 2020 20:28:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200113181625.3130-1-alexandre.torgue@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 12:16 PM, Alexandre Torgue wrote:
> Hi,
> 
> The goal of this series is to add device tree build information in dtb.
> This information can be dtb build date, where devicetree files come from,
> who built the dtb ... Actually, same kind of information that you can find
> in the Linux banner which is printout during kernel boot. Having the same
> kind of information for device tree is useful for debugging and maintenance.
> 
> To achieve that a new option "-B" (using an argument) is added to dtc. 
> The argument is a file containing a string with build information
> (e.g., From Linux 5.5.0-rc1 by alex the Mon Jan 13 18:25:38 CET 2020).
> DTC use it to append dts file with a new string property "Build-info".
> 
> of/fdt.c is modified to printout "Build-info" property during Kernel boot and 
> scripts/Makefile.lib is modified to use dtc -B option during kernel make (this
> last part could be improved for sure).

Please read through the thread at:

  https://lore.kernel.org/linux-arm-kernel/550A42AC.8060104@gmail.com/

which was my attempt to do something similar.

-Frank

> 
> Regards
> Alex
> 
> Alexandre Torgue (3):
>   dtc: Add dtb build information option
>   of: fdt: print dtb build information
>   scripts: Use -B dtc option to generate dtb build information.
> 
>  drivers/of/fdt.c           |  9 +++++++
>  scripts/Makefile.lib       | 11 +++++---
>  scripts/dtc/dtc.c          | 55 +++++++++++++++++++++++++++++++++-----
>  scripts/gen_dtb_build_info | 11 ++++++++
>  4 files changed, 76 insertions(+), 10 deletions(-)
>  create mode 100755 scripts/gen_dtb_build_info
> 

