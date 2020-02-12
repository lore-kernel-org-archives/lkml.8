Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9FC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D53C20659
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruTm3lqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBLNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:45:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45195 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:45:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so2002012oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+9a/C8GLe23HYD/53W97lcvboWXgDPM5I+bKJDpdyw=;
        b=ruTm3lqW2VysvFQ29tg9NgK2kyDCsR7ohgp4u2we/nGM4La/iKBWJCgqKJ0tm2+MR1
         SzeEcJfO+CDWCBGlPrzJ0EXZ3biWOqDsxAIvTMTQAFmOmpwIS+kkyxKt4MFNSDHhFiYl
         TqKjqBUeQoCBxTLwZY0skkn3vLbIkWK3g1ulxuS7yz1ILB3SjvDHVeVsVQvjqUJOMjSD
         yTUdhqenNBftYtyxMsE7saHnHGOnHQcqg75E7+BxR110ybOK5dBdAFkmRRLeG+sKx72V
         tbSAZYcGXhzmE15dI9iOiUa6NTUU3TDt7J9LPmN7w5EMvPWGcY0t5hvq+0PsLgCGWf5y
         c8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=w+9a/C8GLe23HYD/53W97lcvboWXgDPM5I+bKJDpdyw=;
        b=pl0axPX90yuHz0cTrz4WMx8JzbBAODXyxFbrO1Lt+8d3QUgfqQO6LKDMu/qlnoPvXd
         JaXdk8xb69MjO09hlaZdNhQvz275DC6iPWHXe5r367TO26ZehW1P9GFnPKUeh3hgQahg
         wGJ8Fzwn494hTcCKaiwxs6OxHV22AtKy91JLEXQi4Z/mBfCdzqIUelaSZo1EmukQAHoX
         v9XQCJv+dQTkYTEq2UJSggH9xLqoN9PAcNiHpQakaVlOmyiqkIWajOvGMJY8naWc+c+r
         eCZqndC3aCfrXkGg+RJf/wG3sNPYhx3N1Fris1BBaV1XDKE6jvvULYpQoORvxspODu3E
         k1dA==
X-Gm-Message-State: APjAAAWT0JGK9czxC0+VE21W+EZaAHpPCRRnoGFhPscd1ZTGI1v5CW3u
        8qbS6vM0q9Rm4s6vhfsK4g==
X-Google-Smtp-Source: APXvYqwkgvblGx+JRC3ff68p+PCc3tv+uA3GDD2bV0WIyuf0Auq4Vf0YuAu0VPq26OyW80NZ5v2iKg==
X-Received: by 2002:a05:6808:3ae:: with SMTP id n14mr6317402oie.63.1581515157211;
        Wed, 12 Feb 2020 05:45:57 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 108sm185737oti.1.2020.02.12.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 05:45:53 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e166:6491:dd75:4196])
        by serve.minyard.net (Postfix) with ESMTPSA id 5A6DA180053;
        Wed, 12 Feb 2020 13:45:53 +0000 (UTC)
Date:   Wed, 12 Feb 2020 07:45:52 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3] drivers: char: ipmi: ipmi_msghandler: Pass lockdep
 expression to RCU lists
Message-ID: <20200212134552.GN7842@minyard.net>
Reply-To: minyard@acm.org
References: <20200117132521.31020-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117132521.31020-1-frextrite@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 06:55:22PM +0530, Amol Grover wrote:
> intf->cmd_rcvrs is traversed with list_for_each_entry_rcu
> outside an RCU read-side critical section but under the
> protection of intf->cmd_rcvrs_mutex.
> 
> ipmi_interfaces is traversed using list_for_each_entry_rcu
> outside an RCU read-side critical section but under the protection
> of ipmi_interfaces_mutex.
> 
> Hence, add the corresponding lockdep expression to the list traversal
> primitive to silence false-positive lockdep warnings, and
> harden RCU lists.
> 
> Add macro for the corresponding lockdep expression to make the code
> clean and concise.
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>

After reading everything, I think this is correct, but I would like
Paul's stamp of approval on this.

Thanks,

-corey

> ---
> v3:
> - Remove rcu_read_lock_held() from lockdep expression since it is
>   implicitly checked.
> - Remove unintended macro usage.
>  
> v2:
> - Fix sparse error
>   CHECK: Alignment should match open parenthesis
> 
>  drivers/char/ipmi/ipmi_msghandler.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index cad9563f8f48..64ba16dcb681 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -618,6 +618,8 @@ static DEFINE_MUTEX(ipmidriver_mutex);
>  
>  static LIST_HEAD(ipmi_interfaces);
>  static DEFINE_MUTEX(ipmi_interfaces_mutex);
> +#define ipmi_interfaces_mutex_held() \
> +	lockdep_is_held(&ipmi_interfaces_mutex)
>  static struct srcu_struct ipmi_interfaces_srcu;
>  
>  /*
> @@ -1321,7 +1323,8 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
>  	 * synchronize_srcu()) then free everything in that list.
>  	 */
>  	mutex_lock(&intf->cmd_rcvrs_mutex);
> -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
>  		if (rcvr->user == user) {
>  			list_del_rcu(&rcvr->link);
>  			rcvr->next = rcvrs;
> @@ -1599,7 +1602,8 @@ static struct cmd_rcvr *find_cmd_rcvr(struct ipmi_smi *intf,
>  {
>  	struct cmd_rcvr *rcvr;
>  
> -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
>  		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
>  					&& (rcvr->chans & (1 << chan)))
>  			return rcvr;
> @@ -1614,7 +1618,8 @@ static int is_cmd_rcvr_exclusive(struct ipmi_smi *intf,
>  {
>  	struct cmd_rcvr *rcvr;
>  
> -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
>  		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
>  					&& (rcvr->chans & chans))
>  			return 0;
> @@ -3450,7 +3455,8 @@ int ipmi_add_smi(struct module         *owner,
>  	/* Look for a hole in the numbers. */
>  	i = 0;
>  	link = &ipmi_interfaces;
> -	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link) {
> +	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link,
> +				ipmi_interfaces_mutex_held()) {
>  		if (tintf->intf_num != i) {
>  			link = &tintf->link;
>  			break;
> -- 
> 2.24.1
> 
