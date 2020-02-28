Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE60C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04333246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V29Two3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1Ros (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:44:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33672 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Ros (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:44:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so3673149oig.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6odYFUxjVW/kDM7K5IcOeiMB98fdGcFmNhxPrV1QxrU=;
        b=V29Two3r82q98dZeBM8vjtTnh4rtjYfE/b+k+qyZkB2v9hKgV+JjnFRFuUjmUzdBQA
         0GcFHi7BeduXmq1vX3nVHW72D4KlZ7eaRFmE6zzFfGvFNmEAghDjNz9eEkg/vs0mg50B
         GMucagJBbOl9NLxr5lbj0PIAj/NgKdwAoY4UcZkttVVChdRSQb5zFiCcj9VjzSXCBD6v
         Pd3HyaWLybtEcbvcN15qMIODpYm8NW8dBgee848eX+7C51WlVZmf9Ezobx/TFCoRTMdq
         NmJ3deWyqIJ7NBXKf7d2h+iGJfsfVD9D3Uw1f7DWNE5V6VzNfSylICGL5cwKKhnUgflG
         AXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=6odYFUxjVW/kDM7K5IcOeiMB98fdGcFmNhxPrV1QxrU=;
        b=eBESLojkN0F9OvSdEN7u05pvhenf1wHWNP/GWu+PiutFeDNPhYLoM8Pn4nNhVBVEAJ
         d/y2OFQQEEZFYUURp/3r5Gwn1TlLFXfLqtc3YBBgZabbKPqeVO56hbAZm1U3SG9A+ONl
         06Sh/HkNAYL3FnfRNZD0Fzlae16m31X2+uMrrWj2npYrYXCtoyTkQ2WAqT+HwQbh2wmM
         bc3UXy3YuF6ZBbKgQrVfk4kdQPNE879YVqPfa0GT16uOrSc/ILExC8zxxO0HumIhN20n
         QktRNyzGFWQpRDLbYov9lKlHvFdHnTzCMZzd2f6bv7NKkWf5ilX+3ngM0ypB8FIkW1Zj
         UBtg==
X-Gm-Message-State: APjAAAUrQZlcv8MPVcLlIeVGlye9Z4B+aNskQ6k5tUdzRPNZGOvOf/DT
        D7EAmqkQrRqXXoO1Twm3dQ==
X-Google-Smtp-Source: APXvYqwiBFJA4p21dMu8dX7+zOpbTosOuJ9GQtz8NCddtM7ZChaF3RUnufWiwb89RdwCubODYR6/bA==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr3781165oiz.120.1582911886930;
        Fri, 28 Feb 2020 09:44:46 -0800 (PST)
Received: from serve.minyard.net ([47.184.141.150])
        by smtp.gmail.com with ESMTPSA id g5sm3328290otp.10.2020.02.28.09.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:44:46 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:44b4:3c45:39b0:ab94])
        by serve.minyard.net (Postfix) with ESMTPSA id D09A818000D;
        Fri, 28 Feb 2020 17:44:45 +0000 (UTC)
Date:   Fri, 28 Feb 2020 11:44:44 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        John Garry <john.garry@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . Mckenney" <paulmck@kernel.org>
Subject: Re: [PATCH] ipmi: Fix RCU list lockdep debugging warnings
Message-ID: <20200228174444.GE3840@minyard.net>
Reply-To: minyard@acm.org
References: <20200228081731.18149-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228081731.18149-1-frextrite@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 01:47:33PM +0530, Amol Grover wrote:
> It is completely safe to traverse ipmi_interfaces and
> intf->users under SRCU read lock using list_for_each_entry_rcu().
> Tell lockdep about it as well else it will show false-positive
> warnings as the one below.

Thanks, this is queued for 5.7, and I hadded John Garry's test by.

-corey

> 
> Fixes the following false-positive warning and others that may follow.
> 
> [   29.772408] =============================
> [   29.776863] WARNING: suspicious RCU usage
> [   29.780915] 5.6.0-rc3-00001-g907305ae6618-dirty #1755 Not tainted
> [   29.787046] -----------------------------
> [   29.791100] drivers/char/ipmi/ipmi_msghandler.c:744 RCU-list traversed in
> non-reader section!!
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index cad9563f8f48..d202022c69de 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -741,7 +741,8 @@ int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
>  	list_add(&watcher->link, &smi_watchers);
>  
>  	index = srcu_read_lock(&ipmi_interfaces_srcu);
> -	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
> +				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
>  		int intf_num = READ_ONCE(intf->intf_num);
>  
>  		if (intf_num == -1)
> @@ -1188,7 +1189,8 @@ int ipmi_create_user(unsigned int          if_num,
>  		return -ENOMEM;
>  
>  	index = srcu_read_lock(&ipmi_interfaces_srcu);
> -	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
> +				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
>  		if (intf->intf_num == if_num)
>  			goto found;
>  	}
> @@ -1241,7 +1243,8 @@ int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data)
>  	struct ipmi_smi *intf;
>  
>  	index = srcu_read_lock(&ipmi_interfaces_srcu);
> -	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
> +				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
>  		if (intf->intf_num == if_num)
>  			goto found;
>  	}
> @@ -4098,7 +4101,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
>  	 * getting events.
>  	 */
>  	index = srcu_read_lock(&intf->users_srcu);
> -	list_for_each_entry_rcu(user, &intf->users, link) {
> +	list_for_each_entry_rcu(user, &intf->users, link,
> +				srcu_read_lock_held(&intf->users_srcu)) {
>  		if (!user->gets_events)
>  			continue;
>  
> @@ -4453,7 +4457,8 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
>  		int index;
>  
>  		index = srcu_read_lock(&intf->users_srcu);
> -		list_for_each_entry_rcu(user, &intf->users, link) {
> +		list_for_each_entry_rcu(user, &intf->users, link,
> +					srcu_read_lock_held(&intf->users_srcu)) {
>  			if (user->handler->ipmi_watchdog_pretimeout)
>  				user->handler->ipmi_watchdog_pretimeout(
>  					user->handler_data);
> @@ -4746,7 +4751,8 @@ static void ipmi_timeout(struct timer_list *unused)
>  		return;
>  
>  	index = srcu_read_lock(&ipmi_interfaces_srcu);
> -	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
> +				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
>  		if (atomic_read(&intf->event_waiters)) {
>  			intf->ticks_to_req_ev--;
>  			if (intf->ticks_to_req_ev == 0) {
> -- 
> 2.25.0
> 
