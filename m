Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2220C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1932469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgB1D50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:57:26 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:52781 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730586AbgB1D50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:57:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id EB9B0182CED34;
        Fri, 28 Feb 2020 03:57:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flock42_234bed6bf4754
X-Filterd-Recvd-Size: 7374
Received: from XPS-9350 (unknown [172.58.38.199])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 03:57:22 +0000 (UTC)
Message-ID: <11c17de7c525997ddddab995223828bdec8e8e93.camel@perches.com>
Subject: Re: [PATCH 4.14 111/237] tty: synclinkmp: Adjust indentation in
 several functions
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Thu, 27 Feb 2020 19:55:49 -0800
In-Reply-To: <20200227132305.054909944@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
         <20200227132305.054909944@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 14:35 +0100, Greg Kroah-Hartman wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>

I believe these sorts of whitespace only changes should
not be applied to a stable branch unless it's useful for
porting other actual defect fixes.

> [ Upstream commit 1feedf61e7265128244f6993f23421f33dd93dbc ]
> 
> Clang warns:
> 
> ../drivers/tty/synclinkmp.c:1456:3: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>         if (C_CRTSCTS(tty)) {
>         ^
> ../drivers/tty/synclinkmp.c:1453:2: note: previous statement is here
>         if (I_IXOFF(tty))
>         ^
> ../drivers/tty/synclinkmp.c:2473:8: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>                                                 info->port.tty->hw_stopped = 0;
>                                                 ^
> ../drivers/tty/synclinkmp.c:2471:7: note: previous statement is here
>                                                 if ( debug_level >= DEBUG_LEVEL_ISR )
>                                                 ^
> ../drivers/tty/synclinkmp.c:2482:8: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>                                                 info->port.tty->hw_stopped = 1;
>                                                 ^
> ../drivers/tty/synclinkmp.c:2480:7: note: previous statement is here
>                                                 if ( debug_level >= DEBUG_LEVEL_ISR )
>                                                 ^
> ../drivers/tty/synclinkmp.c:2809:3: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>         if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
>         ^
> ../drivers/tty/synclinkmp.c:2807:2: note: previous statement is here
>         if (I_INPCK(info->port.tty))
>         ^
> ../drivers/tty/synclinkmp.c:3246:3: warning: misleading indentation;
> statement is not part of the previous 'else' [-Wmisleading-indentation]
>         set_signals(info);
>         ^
> ../drivers/tty/synclinkmp.c:3244:2: note: previous statement is here
>         else
>         ^
> 5 warnings generated.
> 
> The indentation on these lines is not at all consistent, tabs and spaces
> are mixed together. Convert to just using tabs to be consistent with the
> Linux kernel coding style and eliminate these warnings from clang.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/823
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Link: https://lore.kernel.org/r/20191218024720.3528-1-natechancellor@gmail.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/tty/synclinkmp.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
> index 4fed9e7b281f0..3c9e314406b4e 100644
> --- a/drivers/tty/synclinkmp.c
> +++ b/drivers/tty/synclinkmp.c
> @@ -1467,10 +1467,10 @@ static void throttle(struct tty_struct * tty)
>  	if (I_IXOFF(tty))
>  		send_xchar(tty, STOP_CHAR(tty));
>  
> - 	if (C_CRTSCTS(tty)) {
> +	if (C_CRTSCTS(tty)) {
>  		spin_lock_irqsave(&info->lock,flags);
>  		info->serial_signals &= ~SerialSignal_RTS;
> -	 	set_signals(info);
> +		set_signals(info);
>  		spin_unlock_irqrestore(&info->lock,flags);
>  	}
>  }
> @@ -1496,10 +1496,10 @@ static void unthrottle(struct tty_struct * tty)
>  			send_xchar(tty, START_CHAR(tty));
>  	}
>  
> - 	if (C_CRTSCTS(tty)) {
> +	if (C_CRTSCTS(tty)) {
>  		spin_lock_irqsave(&info->lock,flags);
>  		info->serial_signals |= SerialSignal_RTS;
> -	 	set_signals(info);
> +		set_signals(info);
>  		spin_unlock_irqrestore(&info->lock,flags);
>  	}
>  }
> @@ -2484,7 +2484,7 @@ static void isr_io_pin( SLMP_INFO *info, u16 status )
>  					if (status & SerialSignal_CTS) {
>  						if ( debug_level >= DEBUG_LEVEL_ISR )
>  							printk("CTS tx start...");
> -			 			info->port.tty->hw_stopped = 0;
> +						info->port.tty->hw_stopped = 0;
>  						tx_start(info);
>  						info->pending_bh |= BH_TRANSMIT;
>  						return;
> @@ -2493,7 +2493,7 @@ static void isr_io_pin( SLMP_INFO *info, u16 status )
>  					if (!(status & SerialSignal_CTS)) {
>  						if ( debug_level >= DEBUG_LEVEL_ISR )
>  							printk("CTS tx stop...");
> -			 			info->port.tty->hw_stopped = 1;
> +						info->port.tty->hw_stopped = 1;
>  						tx_stop(info);
>  					}
>  				}
> @@ -2820,8 +2820,8 @@ static void change_params(SLMP_INFO *info)
>  	info->read_status_mask2 = OVRN;
>  	if (I_INPCK(info->port.tty))
>  		info->read_status_mask2 |= PE | FRME;
> - 	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
> - 		info->read_status_mask1 |= BRKD;
> +	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
> +		info->read_status_mask1 |= BRKD;
>  	if (I_IGNPAR(info->port.tty))
>  		info->ignore_status_mask2 |= PE | FRME;
>  	if (I_IGNBRK(info->port.tty)) {
> @@ -3191,7 +3191,7 @@ static int tiocmget(struct tty_struct *tty)
>   	unsigned long flags;
>  
>  	spin_lock_irqsave(&info->lock,flags);
> - 	get_signals(info);
> +	get_signals(info);
>  	spin_unlock_irqrestore(&info->lock,flags);
>  
>  	result = ((info->serial_signals & SerialSignal_RTS) ? TIOCM_RTS : 0) |
> @@ -3229,7 +3229,7 @@ static int tiocmset(struct tty_struct *tty,
>  		info->serial_signals &= ~SerialSignal_DTR;
>  
>  	spin_lock_irqsave(&info->lock,flags);
> - 	set_signals(info);
> +	set_signals(info);
>  	spin_unlock_irqrestore(&info->lock,flags);
>  
>  	return 0;
> @@ -3241,7 +3241,7 @@ static int carrier_raised(struct tty_port *port)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&info->lock,flags);
> - 	get_signals(info);
> +	get_signals(info);
>  	spin_unlock_irqrestore(&info->lock,flags);
>  
>  	return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
> @@ -3257,7 +3257,7 @@ static void dtr_rts(struct tty_port *port, int on)
>  		info->serial_signals |= SerialSignal_RTS | SerialSignal_DTR;
>  	else
>  		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
> - 	set_signals(info);
> +	set_signals(info);
>  	spin_unlock_irqrestore(&info->lock,flags);
>  }
>  

