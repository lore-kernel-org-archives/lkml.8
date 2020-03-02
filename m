Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE74C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A00320866
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcc3FSwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCBVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:13:23 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43081 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCBVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:13:23 -0500
Received: by mail-yw1-f66.google.com with SMTP id p69so1222278ywh.10;
        Mon, 02 Mar 2020 13:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ukeIkjF8FeS+BgwyCl3LqiI7V+t7cDCoO9lW5/Mkvr4=;
        b=hcc3FSwiZtcDcg3aFBjPhq2AiSF/aiBYGhXxOkoz7UWb+Xi3CaV6hLIii4Q7PfQsou
         7uqbGLzcUnGR6vkJjLD6N0AuAAJEISmTGMUnl6srnucy5q9YPaXtpesVWUhERanPoapP
         6StbwOhzdB1sM/7Zhtk8fxuq4li8OtR08tDHNQOWykOAI9850kcNsVN7mmsIeAzPxs4N
         yIc84USsfWc22BcYI0DZVJjCGb3GXDXsPLHC/9UQhoW9jW0ZJ+eU+qlwdJ2F81F2KIf1
         5DLGsZfTE8Pclj4DUfCmTHI59KMIiiBIioxJ5dKi11qfodqyN9hOshqkZze0iH0py/9s
         IxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ukeIkjF8FeS+BgwyCl3LqiI7V+t7cDCoO9lW5/Mkvr4=;
        b=UaONfz6VMdYd/VyYpFd6lGgSexEbQnf45CwN8q7WxH0bCkVUP+PZ10dcGNfTZfs4mC
         3I6dvLPkiB2etroZZKIlqg6eE91MktLeaUS7ppi2jva0epUlJVfLyEOSWoXhrGf6KFAt
         cqA6v320Txiad4BaMm3NNVy+6dV9MjykrJWMcoB8x10mjR8tc8FeMI5UHLSZF8fhagUL
         r3w3KHgII/MqmyLALiSJ4jaPezrBh8TY3lfdxkqfgqLdkbCX26wGUlH0HPX2XnNbtiVY
         7D8N37dAQKBDbzO9u8panHsmJ3sJGqtgjg1aXpdkqez1MDoFDkuu/QKRo5XAVlatoT+X
         S9Zw==
X-Gm-Message-State: ANhLgQ2UYkoBNnWmOv/Vyl2spai0D0e41tRvzNvSgCjw8Yt4/Ht81eeJ
        XMU1R0L9MkhbFw/KLUuH1J0=
X-Google-Smtp-Source: ADFU+vt7KNl+4+oX2x4xh57/+egQAXfv25/y8SwkyTEXcXXJjbAHxm/e2GGOxESvEg8rh56hhG4v5g==
X-Received: by 2002:a25:c246:: with SMTP id s67mr1036970ybf.128.1583183601944;
        Mon, 02 Mar 2020 13:13:21 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id i72sm8453878ywg.49.2020.03.02.13.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 13:13:21 -0800 (PST)
Subject: Re: [PATCH v2 08/12] docs: dt: convert overlay-notes.txt to ReST
 format
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
 <1685e79f7b53c70c64e37841fb4df173094ebd17.1583135507.git.mchehab+huawei@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3fac6196-e9c4-a23d-c5e3-f17367e5db91@gmail.com>
Date:   Mon, 2 Mar 2020 15:13:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1685e79f7b53c70c64e37841fb4df173094ebd17.1583135507.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to devicetree/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/index.rst            |   1 +
>  .../{overlay-notes.txt => overlay-notes.rst}  | 141 +++++++++---------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 74 insertions(+), 70 deletions(-)
>  rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (56%)
> 
> diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> index ca83258fbba5..0669a53fc617 100644
> --- a/Documentation/devicetree/index.rst
> +++ b/Documentation/devicetree/index.rst
> @@ -13,3 +13,4 @@ Open Firmware and Device Tree
>     changesets
>     dynamic-resolution-notes
>     of_unittest
> +   overlay-notes
> diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.rst
> similarity index 56%
> rename from Documentation/devicetree/overlay-notes.txt
> rename to Documentation/devicetree/overlay-notes.rst
> index 3f20a39e4bc2..7e8e568f64a8 100644
> --- a/Documentation/devicetree/overlay-notes.txt
> +++ b/Documentation/devicetree/overlay-notes.rst

There is a collision between 08/12 and a patch I sent a couple of days ago:

   https://lore.kernel.org/r/1580171838-1770-1-git-send-email-frowand.list@gmail.com

-Frank


> @@ -1,5 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
>  Device Tree Overlay Notes
> --------------------------
> +=========================
>  
>  This document describes the implementation of the in-kernel
>  device tree overlay functionality residing in drivers/of/overlay.c and is a
> @@ -15,68 +18,68 @@ Since the kernel mainly deals with devices, any new device node that result
>  in an active device should have it created while if the device node is either
>  disabled or removed all together, the affected device should be deregistered.
>  
> -Lets take an example where we have a foo board with the following base tree:
> -
> ----- foo.dts -----------------------------------------------------------------
> -	/* FOO platform */
> -	/ {
> -		compatible = "corp,foo";
> -
> -		/* shared resources */
> -		res: res {
> -		};
> -
> -		/* On chip peripherals */
> -		ocp: ocp {
> -			/* peripherals that are always instantiated */
> -			peripheral1 { ... };
> -		}
> -	};
> ----- foo.dts -----------------------------------------------------------------
> -
> -The overlay bar.dts, when loaded (and resolved as described in [1]) should
> -
> ----- bar.dts -----------------------------------------------------------------
> -/plugin/;	/* allow undefined label references and record them */
> -/ {
> -	....	/* various properties for loader use; i.e. part id etc. */
> -	fragment@0 {
> -		target = <&ocp>;
> -		__overlay__ {
> -			/* bar peripheral */
> -			bar {
> -				compatible = "corp,bar";
> -				... /* various properties and child nodes */
> -			}
> -		};
> -	};
> -};
> ----- bar.dts -----------------------------------------------------------------
> -
> -result in foo+bar.dts
> -
> ----- foo+bar.dts -------------------------------------------------------------
> -	/* FOO platform + bar peripheral */
> -	/ {
> -		compatible = "corp,foo";
> -
> -		/* shared resources */
> -		res: res {
> -		};
> -
> -		/* On chip peripherals */
> -		ocp: ocp {
> -			/* peripherals that are always instantiated */
> -			peripheral1 { ... };
> -
> -			/* bar peripheral */
> -			bar {
> -				compatible = "corp,bar";
> -				... /* various properties and child nodes */
> -			}
> -		}
> -	};
> ----- foo+bar.dts -------------------------------------------------------------
> +Lets take an example where we have a foo board with the following base tree::
> +
> +    ---- foo.dts --------------------------------------------------------------
> +	    /* FOO platform */
> +	    / {
> +		    compatible = "corp,foo";
> +
> +		    /* shared resources */
> +		    res: res {
> +		    };
> +
> +		    /* On chip peripherals */
> +		    ocp: ocp {
> +			    /* peripherals that are always instantiated */
> +			    peripheral1 { ... };
> +		    }
> +	    };
> +    ---- foo.dts --------------------------------------------------------------
> +
> +The overlay bar.dts, when loaded (and resolved as described in [1]) should::
> +
> +    ---- bar.dts --------------------------------------------------------------
> +    /plugin/;	/* allow undefined label references and record them */
> +    / {
> +	    ....	/* various properties for loader use; i.e. part id etc. */
> +	    fragment@0 {
> +		    target = <&ocp>;
> +		    __overlay__ {
> +			    /* bar peripheral */
> +			    bar {
> +				    compatible = "corp,bar";
> +				    ... /* various properties and child nodes */
> +			    }
> +		    };
> +	    };
> +    };
> +    ---- bar.dts --------------------------------------------------------------
> +
> +result in foo+bar.dts::
> +
> +    ---- foo+bar.dts ----------------------------------------------------------
> +	    /* FOO platform + bar peripheral */
> +	    / {
> +		    compatible = "corp,foo";
> +
> +		    /* shared resources */
> +		    res: res {
> +		    };
> +
> +		    /* On chip peripherals */
> +		    ocp: ocp {
> +			    /* peripherals that are always instantiated */
> +			    peripheral1 { ... };
> +
> +			    /* bar peripheral */
> +			    bar {
> +				    compatible = "corp,bar";
> +				    ... /* various properties and child nodes */
> +			    }
> +		    }
> +	    };
> +    ---- foo+bar.dts ----------------------------------------------------------
>  
>  As a result of the overlay, a new device node (bar) has been created
>  so a bar platform device will be registered and if a matching device driver
> @@ -88,11 +91,11 @@ Overlay in-kernel API
>  The API is quite easy to use.
>  
>  1. Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
> -return value is an error or a cookie identifying this overlay.
> +   return value is an error or a cookie identifying this overlay.
>  
>  2. Call of_overlay_remove() to remove and cleanup the overlay changeset
> -previously created via the call to of_overlay_fdt_apply(). Removal of an
> -overlay changeset that is stacked by another will not be permitted.
> +   previously created via the call to of_overlay_fdt_apply(). Removal of an
> +   overlay changeset that is stacked by another will not be permitted.
>  
>  Finally, if you need to remove all overlays in one-go, just call
>  of_overlay_remove_all() which will remove every single one in the correct
> @@ -109,9 +112,9 @@ respective node it received.
>  Overlay DTS Format
>  ------------------
>  
> -The DTS of an overlay should have the following format:
> +The DTS of an overlay should have the following format::
>  
> -{
> +    {
>  	/* ignored properties by the overlay */
>  
>  	fragment@0 {	/* first child node */
> @@ -131,7 +134,7 @@ The DTS of an overlay should have the following format:
>  		...
>  	};
>  	/* more fragments follow */
> -}
> +    }
>  
>  Using the non-phandle based target method allows one to use a base DT which does
>  not contain a __symbols__ node, i.e. it was not compiled with the -@ option.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1380b1ed69a2..3f679cb4b330 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12459,7 +12459,7 @@ M:	Frank Rowand <frowand.list@gmail.com>
>  L:	devicetree@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/dynamic-resolution-notes.rst
> -F:	Documentation/devicetree/overlay-notes.txt
> +F:	Documentation/devicetree/overlay-notes.rst
>  F:	drivers/of/overlay.c
>  F:	drivers/of/resolver.c
>  K:	of_overlay_notifier_
> 

