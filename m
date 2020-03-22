Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C7C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A41B20724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJvUhtoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCVSe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:34:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34151 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 14:34:55 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so11893540iof.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I96GfMTGq9tUWRXE8nK4GMh5+Rk8r1hA4SJWjtfIz8c=;
        b=rJvUhtoJSZoJZ59xKruwqvuxmnNykSJnrdZl61bfZeAwFcD2KOYValDzc3KdUgDuzo
         Fs84zAqxmx6HmXvBbsccutjeE56+jKXSZVYKNibpIxJghE5tCF6rmWXT4tps1fo4+nJh
         n8PDln4LMaInk0pGEk1GAEPhJ6XUdael/r3ZeLaJtimq6/Q4TxJRU/90wU+WutYNccVl
         8kJVfc3jvWlWUaEfHDmmsVpaqXkml9GKOhxLpBNQ+fXBGbMbT5YpB8K1dCYrUwpB6c21
         aet7+AQPCCjURaqqSSA9ANtEFxfXJb8WcurJBw15kGHaLzCfKR4gu1wZzC8D8jL1Mc9M
         ey6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I96GfMTGq9tUWRXE8nK4GMh5+Rk8r1hA4SJWjtfIz8c=;
        b=ZaZCqHUUDKaeDGAJOCmoVSlQg2e9Sjh7OLEXHrml6pWCftINPi5OzlvkAU5OhwsZqG
         5UyjVE9DcwyiK8W/fsHUhDEauxgCxM1sDLaK9pi/HEggJFJBHdIFkfW9ci9d8Maa29V+
         MDYXcSBQn8Wy1qlxHYSYx3uUVmS10j8uSg+r5josyKa8Em44pCoGnGhKDFP2AHanrJwm
         mhlFZjIsdegxKf0t9BNFL0opMo74DGa+6lL+wIn6iBTqgtPs60DtJPwcNTFxYCtu2Wju
         Ly7QE1PukJq/PUjEBihn4503yBcSdUZvR6DFC0bpC3vYc3GAD8fDSNgbg3myPjJrMEL5
         +bkQ==
X-Gm-Message-State: ANhLgQ2OldRXJtRSEf+TfXamigk/hutu9mD8Upd2s2iDTELwkM7fTuqH
        odmhGRbyqRXgok+ux6A8nd0W9g==
X-Google-Smtp-Source: ADFU+vvrk/Ou3tOtIOKEMMAqZ7PMZvdC4HXpfkqhgNXtBlpBKJE3/XcxE4hujRiRTCDop7ZBPLp45g==
X-Received: by 2002:a02:7a07:: with SMTP id a7mr17054094jac.96.1584902093315;
        Sun, 22 Mar 2020 11:34:53 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id d15sm614598ioe.49.2020.03.22.11.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 11:34:52 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] staging: greybus: tools: Fix braces {}
 style
To:     Simran Singhal <singhalsimran0@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
References: <20200322173045.GA24700@simran-Inspiron-5558>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7fc65c6f-1f1d-8f60-faad-e43dda3d0cfa@linaro.org>
Date:   Sun, 22 Mar 2020 13:34:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200322173045.GA24700@simran-Inspiron-5558>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/20 12:30 PM, Simran Singhal wrote:
> This patch fixes the check reported by checkpatch.pl
> for braces {} should be used on all arms of this statement.
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>

Looks fine to me.  And I saw no other instances of this in the
Greybus code.  Thanks for the patch.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/staging/greybus/tools/loopback_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
> index ba6f905f26fa..d46721502897 100644
> --- a/drivers/staging/greybus/tools/loopback_test.c
> +++ b/drivers/staging/greybus/tools/loopback_test.c
> @@ -801,8 +801,9 @@ static void prepare_devices(struct loopback_test *t)
>  			write_sysfs_val(t->devices[i].sysfs_entry,
>  					"outstanding_operations_max",
>  					t->async_outstanding_operations);
> -		} else
> +		} else {
>  			write_sysfs_val(t->devices[i].sysfs_entry, "async", 0);
> +		}
>  	}
>  }
>  
> 

