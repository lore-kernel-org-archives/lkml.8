Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC62C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89CF214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgHUFdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:33:07 -0400
Received: from goliath.siemens.de ([192.35.17.28]:37185 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUFdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:33:07 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07L5X0Xb000536
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 07:33:00 +0200
Received: from [167.87.31.209] ([167.87.31.209])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07L5Wx6m017761;
        Fri, 21 Aug 2020 07:32:59 +0200
Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow
 control
To:     Sheng Long Wang <china_shenglong@163.com>,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200820075240.13321-1-china_shenglong@163.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <97836b78-740b-cf70-4803-27305b6e0a4d@siemens.com>
Date:   Fri, 21 Aug 2020 07:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820075240.13321-1-china_shenglong@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.20 09:52, Sheng Long Wang wrote:
> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> When data is transmitted between two serial ports,
> the phenomenon of data loss often occurs. The two kinds
> of flow control commonly used in serial communication
> are hardware flow control and software flow control.
> 
> In serial communication, If you only use RX/TX/GND Pins, you
> can't do hardware flow. So we often used software flow control
> and prevent data loss. The user sets the software flow control
> through the application program, and the application program
> sets the software flow control mode for the serial port
> chip through the driver.
> 
> For the cp210 serial port chip, its driver lacks the
> software flow control setting code, so the user cannot set
> the software flow control function through the application
> program. This adds the missing software flow control.
> 
> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> Changes in v3:
> -fixed code style, It mainly adjusts the code style acccording
>  to kernel specification.

Patch does not apply. You forgot to rebase over latest tty/tty-next or
linux master.

Jan

> ---
>  drivers/usb/serial/cp210x.c | 118 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index e732949f65..c66a0e0fb9 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -380,6 +380,9 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  #define CP210X_PARTNUM_CP2102N_QFN20	0x22
>  #define CP210X_PARTNUM_UNKNOWN	0xFF
>  
> +#define CP210X_VSTART	0x11
> +#define CP210X_VSTOP	0x13
> +
>  /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
>  struct cp210x_comm_status {
>  	__le32   ulErrors;
> @@ -391,6 +394,15 @@ struct cp210x_comm_status {
>  	u8       bReserved;
>  } __packed;
>  
> +struct cp210x_chars_response {
> +	u8	eofchar;
> +	u8	errochar;
> +	u8	breakchar;
> +	u8	eventchar;
> +	u8	xonchar;
> +	u8	xoffchar;
> +} __packed;
> +
>  /*
>   * CP210X_PURGE - 16 bits passed in wValue of USB request.
>   * SiLabs app note AN571 gives a strange description of the 4 bits:
> @@ -624,6 +636,45 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  	return result;
>  }
>  
> +/*
> + * Read and Write Character Responses operate
> + * Register SET_CHARS/GET_CHATS
> + */
> +static int cp210x_operate_chars_block(struct usb_serial_port *port,
> +				u8 req, u8 type, void *buf, int bufsize)
> +{
> +	struct usb_serial *serial = port->serial;
> +	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> +	void *dmabuf;
> +	int result;
> +
> +	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	result = usb_control_msg(serial->dev,
> +				usb_rcvctrlpipe(serial->dev, 0),
> +				req, type, 0, port_priv->bInterfaceNumber,
> +				dmabuf, bufsize, USB_CTRL_SET_TIMEOUT);
> +
> +	if (result == bufsize) {
> +		if (type == REQTYPE_DEVICE_TO_HOST)
> +			memcpy(buf, dmabuf, bufsize);
> +
> +		result = 0;
> +	} else {
> +		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
> +			req, bufsize, result);
> +		if (result >= 0)
> +			result = -EIO;
> +
> +	}
> +
> +	kfree(dmabuf);
> +
> +	return result;
> +}
> +
>  /*
>   * Writes any 16-bit CP210X_ register (req) whose value is passed
>   * entirely in the wValue field of the USB request.
> @@ -1134,11 +1185,17 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
>  	struct device *dev = &port->dev;
> -	unsigned int cflag, old_cflag;
> +	struct cp210x_chars_response charsres;
> +	struct cp210x_flow_ctl flow_ctl;
> +	unsigned int cflag, old_cflag, iflag;
>  	u16 bits;
> +	int result;
> +	u32 ctl_hs;
> +	u32 flow_repl;
>  
>  	cflag = tty->termios.c_cflag;
>  	old_cflag = old_termios->c_cflag;
> +	iflag = tty->termios.c_iflag;
>  
>  	if (tty->termios.c_ospeed != old_termios->c_ospeed)
>  		cp210x_change_speed(tty, port, old_termios);
> @@ -1212,10 +1269,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  	}
>  
>  	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
> -		struct cp210x_flow_ctl flow_ctl;
> -		u32 ctl_hs;
> -		u32 flow_repl;
> -
>  		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
>  				sizeof(flow_ctl));
>  		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> @@ -1252,6 +1305,61 @@ static void cp210x_set_termios(struct tty_struct *tty,
>  				sizeof(flow_ctl));
>  	}
>  
> +	/*
> +	 * Set Software  Flow  Control
> +	 * Check the IXOFF/IXON status in the iflag component of the
> +	 * termios structure.
> +	 *
> +	 */
> +	if ((iflag & IXOFF) || (iflag & IXON)) {
> +
> +		result = cp210x_operate_chars_block(port,
> +						CP210X_GET_CHARS,
> +						REQTYPE_DEVICE_TO_HOST,
> +						&charsres,
> +						sizeof(charsres));
> +
> +		if (result < 0) {
> +			dev_err(dev, "Read Characrter Responses failed\n");
> +			return;
> +		}
> +		charsres.xonchar  = CP210X_VSTART;
> +		charsres.xoffchar = CP210X_VSTOP;
> +		result = cp210x_operate_chars_block(port,
> +						CP210X_SET_CHARS,
> +						REQTYPE_HOST_TO_INTERFACE,
> +						&charsres,
> +						sizeof(charsres));
> +		if (result < 0) {
> +			memset(&charsres, 0, sizeof(charsres));
> +			dev_err(dev, "Write Characrter Responses failed\n");
> +			return;
> +		}
> +
> +		/*Set  Rx/Tx Flow Contrl  Flag in ulFlowReplace*/
> +		cp210x_read_reg_block(port,
> +					CP210X_GET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));
> +
> +		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +
> +		if (iflag & IXOFF)
> +			flow_repl |= CP210X_SERIAL_AUTO_RECEIVE;
> +		else
> +			flow_repl &= ~CP210X_SERIAL_AUTO_RECEIVE;
> +
> +		if (iflag & IXON)
> +			flow_repl |= CP210X_SERIAL_AUTO_TRANSMIT;
> +		else
> +			flow_repl &= ~CP210X_SERIAL_AUTO_TRANSMIT;
> +
> +		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
> +		cp210x_write_reg_block(port,
> +					CP210X_SET_FLOW,
> +					&flow_ctl,
> +					sizeof(flow_ctl));
> +	}
>  }
>  
>  static int cp210x_tiocmset(struct tty_struct *tty,
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
