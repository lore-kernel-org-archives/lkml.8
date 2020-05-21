Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3465F20759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="MNKVdqYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgEUIS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgEUISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:18:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9343EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:18:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u1so4806542wmn.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bqOLOWJcEnmegQMbnR/7WAD5Ory2NkimcCLFj6PkXT4=;
        b=MNKVdqYIQu1sZpEEWrjFHTTAgUy+R5a9ibTbTktvHRxg5WU3UwsT+DYDhAfDTZ1ZVN
         WUkF2IPbZmlF4VcwHRt2g+0rwVYfAWsxUMpNDxOZKs9mfmROSBdrBuvxcGKRLC1byQ50
         gtHo3VrT/HT9vEGVkBYTSpJJxyNB1z1PPj1jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bqOLOWJcEnmegQMbnR/7WAD5Ory2NkimcCLFj6PkXT4=;
        b=SitCp9dlGaJqsZcFz9vodRjt7JrkUwuhb1ne0+W6O4tGpHi2GWGft7OcH/Ltf3egq9
         cdMp/Kl2ja1OlQ0ttz6knmlCuFkfFOa8IHjnWAaTQuYFr9EyiiKZNW/rNlY+cAXCSDYg
         Cg8Be2d063zEH0/r8mNG9XWz3aAlX4hVpYyH1J3vdQ2ZUikQ4nEFDYlLmhQqe0UcCnsn
         DqrNOGIzUmgfw1+hMHQ2AIaK2LAZCsfZ4wdNHR71i0RQpQ7zEHmWFd2rISt/Ek6KX6CO
         YtBnlKMzT7YI9FKfcCCUEbNZsV2XJcdmHIxBxEDlOevR+cFygWZ/2K/g6PLTtY+JoYvF
         MBEQ==
X-Gm-Message-State: AOAM532XXBLv87V1a3Rt/JxS9OOYyAUs8CHAr7BsHYemW8UA+fBI+AMn
        zwow3kwqvtQMCaZvYTaCzCzDpQ==
X-Google-Smtp-Source: ABdhPJwnoCs1FS19UI5zCtlLZR/jxDVg7B/c15iE+aCCyvnmoKKyxYyfj6nzMcAhOF8kUgyhShWwQg==
X-Received: by 2002:a1c:2186:: with SMTP id h128mr7558309wmh.108.1590049104333;
        Thu, 21 May 2020 01:18:24 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id v2sm5840676wrn.21.2020.05.21.01.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 01:18:23 -0700 (PDT)
Subject: Re: [PATCH 3/3] bridge: mrp: Restore port state when deleting MRP
 instance
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, jiri@resnulli.us,
        ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org,
        roopa@cumulusnetworks.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
 <20200520130923.3196432-4-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <05ddf496-9f6d-ae23-1bdb-40f0fe0e3b3c@cumulusnetworks.com>
Date:   Thu, 21 May 2020 11:18:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200520130923.3196432-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2020 16:09, Horatiu Vultur wrote:
> When a MRP instance is deleted, then restore the port according to the
> bridge state. If the bridge is up then the ports will be in forwarding
> state otherwise will be in disabled state.
> 
> Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index a5a3fa59c078a..bdd8920c15053 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -229,6 +229,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
>  static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
>  {
>  	struct net_bridge_port *p;
> +	u8 state;
>  
>  	/* Stop sending MRP_Test frames */
>  	cancel_delayed_work_sync(&mrp->test_work);
> @@ -240,20 +241,24 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
>  	p = rtnl_dereference(mrp->p_port);
>  	if (p) {
>  		spin_lock_bh(&br->lock);
> -		p->state = BR_STATE_FORWARDING;
> +		state = netif_running(br->dev) ?
> +				BR_STATE_FORWARDING : BR_STATE_DISABLED;
> +		p->state = state;
>  		p->flags &= ~BR_MRP_AWARE;
>  		spin_unlock_bh(&br->lock);
> -		br_mrp_port_switchdev_set_state(p, BR_STATE_FORWARDING);
> +		br_mrp_port_switchdev_set_state(p, state);
>  		rcu_assign_pointer(mrp->p_port, NULL);
>  	}
>  
>  	p = rtnl_dereference(mrp->s_port);
>  	if (p) {
>  		spin_lock_bh(&br->lock);
> -		p->state = BR_STATE_FORWARDING;
> +		state = netif_running(br->dev) ?
> +				BR_STATE_FORWARDING : BR_STATE_DISABLED;
> +		p->state = state;
>  		p->flags &= ~BR_MRP_AWARE;
>  		spin_unlock_bh(&br->lock);
> -		br_mrp_port_switchdev_set_state(p, BR_STATE_FORWARDING);
> +		br_mrp_port_switchdev_set_state(p, state);
>  		rcu_assign_pointer(mrp->s_port, NULL);
>  	}
>  
> 

