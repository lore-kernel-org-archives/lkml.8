Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC3C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AEB2467D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE9G1Ada"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgBLUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:45:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40876 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgBLUpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:45:47 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so1383877pjb.5;
        Wed, 12 Feb 2020 12:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPrKuRi6FOCenz8x5HDZUpKjL7/Vbor3/MAzvMLKF5E=;
        b=OE9G1AdasJTFsKzJWS8850awYaQjFlzggWaPKTYdJhH+RGC10+WE4Oyg/tol+Y06BN
         T+vNbnd1sRGxIOa43ic9tL98yjpP+w5izvAGPhAL6iapL73WaUwLIi5O/KDWY2UhX9Bj
         4ivnKKvWWdLpLM/4spAH9rGtIwpl0zyhsNvafOjIjLZWEfNQZhZ/+eNIIWrXTc5cMWf4
         xxEauh0uxljia3qMFyX1lmgC3buYcF+U22KGAj+/pB8FXK/vqRQ1J7n5u0UoL8CKLGdf
         jaoMvScNI6iFvOmsFJ0MjE7j4zkAlY4/vRcT2B9FdgUeyq+/vmv3R8ex0bHoRNOwmGvk
         ubuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPrKuRi6FOCenz8x5HDZUpKjL7/Vbor3/MAzvMLKF5E=;
        b=XBM0gvdXBZx6iTNPuXLK9ZtZkGsFlVXBowCUL7VXx1cPWgfWfjo3bu0Ob/ydZfF4Yx
         UvmffpNdI53kvh0QkIqoh9FuD/C2t+71zAuz94+7Ya0K9mRmyCsDilGmkF3AptLQAs4P
         YisHsomZNXrkZ1X+NBJXNhaq12lLat5nxmNgc5W05kV7fJv3+A4f7SJg+Cv46THDXLhB
         NNwAuyJxqibgfC4xUwAwdnpnHNFZGiTx4WdVnaYTSILr0O6fSVySRcgOpthJxeFGKABo
         ZSZbqUAEcok3P4/Awpw5bwTEOJA9DTxT5HhXFZVlg6S5u3EZBZdNSgguH4Zr2p4L1xFz
         3KhQ==
X-Gm-Message-State: APjAAAVhrcQEIvV6o//5yuN9rEH3F/HDIR76zVRJ1zDF9r+rj7X3j7H1
        3+PA+P38RYOcUyrNpe4XAk0=
X-Google-Smtp-Source: APXvYqxVHlUd3V0YAJLj7a1864k4eFqZ6YOFpcoO/yGan1cBrkCH/1mAgFrufk2ZuU/R+82aoLhEGw==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr10290430plr.237.1581540345301;
        Wed, 12 Feb 2020 12:45:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 199sm128759pfu.71.2020.02.12.12.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 12:45:44 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:45:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ibmaem) Replace zero-length array with
 flexible-array member
Message-ID: <20200212204543.GA7197@roeck-us.net>
References: <20200211234237.GA26971@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211234237.GA26971@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:42:37PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ibmaem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
> index db63c1295cb2..fb052c2d9c34 100644
> --- a/drivers/hwmon/ibmaem.c
> +++ b/drivers/hwmon/ibmaem.c
> @@ -232,7 +232,7 @@ struct aem_read_sensor_req {
>  
>  struct aem_read_sensor_resp {
>  	struct aem_iana_id	id;
> -	u8			bytes[0];
> +	u8			bytes[];
>  } __packed;
>  
>  /* Data structures to talk to the IPMI layer */
