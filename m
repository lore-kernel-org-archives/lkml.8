Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A608C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D832205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntboDvPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgCXUwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:52:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34492 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCXUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:52:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so7929262plm.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUH2GpKiZzcp+HWMY8/0tgoroE59nDoZuKy+VZo5HoQ=;
        b=ntboDvPpO4mkIqoOhoGXBG65LwzTrCrhDR8XrhgItSkYAvVx0nDaIFCBhgwlE8+b3B
         y6p8/oHwZoumQYYk3A1AzzxHVkXT6O6foFkaxu4imEmIvRAWv/oMpfPHGgbxrTvRWSJk
         gIFK1Am2GLRwaAk5axXIPgh23srMlz0n3DanoTyOa9GDaxu/vLb4pd80gJuGfXRZvFfN
         9yYECe7ugpWAGzj2sy3/0p4O61zScSUI1p0bkfKRlTrUSt8hghGolfUp584p846q7sI+
         TWvUS7SFV62KctatZgmzNHcZ4+uPfa12URZyyig2GjXYpWMhIgTHXJNzdoKULwuNqvOT
         xpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUH2GpKiZzcp+HWMY8/0tgoroE59nDoZuKy+VZo5HoQ=;
        b=qugirZcyb47YDu7hcmPd+Bq4p3trwVAiDPMcXhe2x2hn4HWMayG1Y52Y3PojLizV8d
         BO3NdfHlXKn5pKULs5R0cFVZFiSaQ2bN5lG3i8zPyc4bzhW+Ym4xs9myIDv1+nJ9oDUL
         dxwNhnzdlI14eO1hDGRkVVcXLUqUij+NjGXqMDnwU2hvucEHxH0CDcPuOkcxMWSfPhC/
         h5R8lzmNDXiziRn12N36q53FMXnfR0wtagepUtWWgVV5rzfCjEalF76+2r94G5GcWlw1
         S3N+G02JBejqCKZGvUay+55/AY1PjPDiCV9aY0KbFWqgCAoKiRAFHtfyyd3aCee0i28K
         F6LQ==
X-Gm-Message-State: ANhLgQ3f20joclf5UGhLk7gIwhZUaHnqVY+uyPf/Yl89/GZPIGlN5mbt
        oEkWrDvOCq3Ii6uRvpJ8kBTKFQ==
X-Google-Smtp-Source: ADFU+vuFTdjBOEELC4vADOx1eo0GZ5R9fhZn/of+Gz8RGRkQBwgXM30Df8fjCPIj52s2Ffu2c1Bidw==
X-Received: by 2002:a17:902:b281:: with SMTP id u1mr6218733plr.287.1585083133418;
        Tue, 24 Mar 2020 13:52:13 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z6sm16696078pfn.212.2020.03.24.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:52:12 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:52:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        xiang xiao <xiaoxiang781216@gmail.com>
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
Message-ID: <20200324205210.GE119913@minitux>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324170407.16470-3-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Mar 10:04 PDT 2020, Arnaud Pouliquen wrote:
[..]
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 020b1cd9294f..c2465e7ebc2a 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>  obj-$(CONFIG_VCC)		+= vcc.o
> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
>  
>  obj-y += ipwireless/
> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
[..]
> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
> +	{ .name	= TTY_CH_NAME_RAW },
> +	{ .name	= TTY_CH_NAME_WITH_CTS},

I still don't like the idea that the tty devices are tied to channels by
fixed names.

This makes the driver unusable for communicating with any firmware out
there that provides tty-like data over a channel with a different name -
such as modems with channels providing an AT command interface (they are
not named "rpmsg-tty-raw").

I also fail to see how you would distinguish ttys when the firmware
provides more than a single tty - e.g. say you have a modem-like device
that provides an AT command channel and a NMEA stream.


These are the reasons why drivers/rpmsg/rpmsg_char registers a "control
device", from which you can spawn new char devices. As I've said before,
I really think the same approach should be taken for ttys - perhaps by
just extending the rpmsg_char to allow it to create tty devices in
addition to the "packet based" char device?

Regards,
Bjorn
