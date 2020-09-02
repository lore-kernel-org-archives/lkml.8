Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E9C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CEE207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ2Y2w+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIBQ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:57:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C17C061244;
        Wed,  2 Sep 2020 09:57:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so2839217pgm.7;
        Wed, 02 Sep 2020 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2xZ0ZoFG70NkdUFyqdi8QAezKVnUW8TlFis+TNiOMA=;
        b=eJ2Y2w+twA9/KRNYMeFDNfziLBY9T77SEP5t7P7nUdAMvRSFKCUSUoyROGOkffd1WB
         WK9VWfb/p1T2A5JhFZyJkEN8ViiWJtgY5hVI8nFvUARvm+9Lfxh7cO2ZrlyufUGtgaY8
         Vj39NUF1dBGCJmt/rdxIdvuloOZ7J4fg3oWgese8YhEsKh0fNrOqY3vDIntMsVWLvE+k
         Huu2AFFn9akPOsqFC3VJY27EQ3r1rjXzHO0hjIvz2ShYoMH+IESC/qOaV8GeobEw0Bu+
         sRVBdTjKy+mvQ6T/84BtY+5obiZ/vJvvxEresNTqKubSV89OEkHXkJxSFGkMQEctI2wN
         0oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2xZ0ZoFG70NkdUFyqdi8QAezKVnUW8TlFis+TNiOMA=;
        b=qZJ6T7T8GwSCiqA7iicTpfjnN0OC2Ew3r2Smef67Zix6t3UTwcezK6WKcOcTlSDRW5
         Bt1gP3nO70ZiGyyRShjV8BOnXCpL9wHKQaA8c63kozdIp1ReipTVJ8eRE51Sn06nqFx4
         SK7hJetUE7dCw+KBo2KRlCm4Qn8/XORYEQvekJk471hCGM0F5s9lQIECNlx8hjXvnRB8
         ma6PFd268keJeqwhVeLWDGT4mzStsAbDOg+BZrItUJqYmslBm7S3RxbeFXhJyw1AKAxK
         xlNVek2ZYfCqDT0Jra/b9KIx7Fyl6nhQXN86BIcpc2I4mjJ4/ytdpauv86CTn0Y4qAvw
         b9Dg==
X-Gm-Message-State: AOAM5323LithBZ+w7vbicfIn5Ru3+0Aa6C5MyY7AjCd55MthuHZnCvaF
        3jh4aMUV1zWhhNabapxfNiwL3d5ywgE=
X-Google-Smtp-Source: ABdhPJwn0IOIe0oX5jnT9VSHbOFIuLgkkgBLv9LUUwZrT2+SPKkq0lqA0YK/6ttb6F5JvlHAQC/bEQ==
X-Received: by 2002:a63:9d09:: with SMTP id i9mr2491983pgd.381.1599065834749;
        Wed, 02 Sep 2020 09:57:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m4sm23442pfh.129.2020.09.02.09.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 09:57:14 -0700 (PDT)
Date:   Wed, 2 Sep 2020 09:57:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     cy_huang <u0084500@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
 hard_reset_count not reset issue
Message-ID: <20200902165713.GG56237@roeck-us.net>
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:35:33PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Fix: If vbus event is before cc_event trigger, hard_reset_count
> won't bt reset for some case.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Below's the flow.
> 
> _tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_UNATTACHED
> call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
> tcpm_port_is_disconnected() will be called.
> But port->attached is still true and port->cc1=open and port->cc2=open
> 
> It cause tcpm_port_is_disconnected return false, then hard_reset_count won't be reset.
> After that, tcpm_reset_port() is called.
> port->attached become false.
> 
> After that, cc now trigger cc_change event, the hard_reset_count will be kept.
> Even tcpm_detach will be called, due to port->attached is false, tcpm_detach()
> will directly return.
> 
> CC_EVENT will only trigger drp toggling again.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a48e3f90..5c73e1d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *port)
>  		port->tcpc->set_bist_data(port->tcpc, false);
>  	}
>  
> -	if (tcpm_port_is_disconnected(port))
> -		port->hard_reset_count = 0;
> +	port->hard_reset_count = 0;
>  

Doesn't that mean that the state machine will never enter
error recovery ?

Guenter

>  	tcpm_reset_port(port);
>  }
> -- 
> 2.7.4
> 
