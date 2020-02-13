Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6D6C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B362168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS8Dc8pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgBMNEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:04:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40349 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgBMNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:04:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so5453725otr.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0adB+pt4qh1OaTMfcot+CB7VlM3xlqwZE8/MPGMlo18=;
        b=NS8Dc8pFZ/7KzwYyztK06wo2fsUH6hYpT2WDma2QuQjZFYqSp8rrXFU+RY00kN6Y/9
         oddxJ9ID4bE35Hx6odPhqy3eH/fBVz1r1vEUMWKSBQu3tS964k0Bkoeh8CD28Za40Y/A
         QnvqmnYp9dwUSQLDusy3v0bDsHSCjYDQh5INRrCBD1LF75hZIKkjyFWgeKfIhddnaitC
         GGY0QuyWCrVJn+3AN341O04AFg0zpeQMSpsOPfkh0niNKYrRQSka563XfPEPa8AfnNbZ
         dFl291zS+Fjw4iNro/6KKF62pYJiHT6tV5wIudqoQMcROo+FthxlrFgYTKVz/nEPWYw9
         GcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=0adB+pt4qh1OaTMfcot+CB7VlM3xlqwZE8/MPGMlo18=;
        b=HxzqBeKUyfEOmnpX9qyrCZIg7Af5fcRRjEWBjw43POyeKD7O/qsXwOiUf+DkvwjFjf
         ak6pMdL4b+/r0LVOq4FlHCSYIPfXAD3NB0Lu53szeaO7ZTK+VUBemOx/8NVtoYHGyU1L
         hgcmO+pcqiDiNFdZC4cmwEw6FBsBQMdK+vraaL67GCmi5Jd3Av+nE5gStKfnchw7GljB
         kyd0QRavHT0WBuvy3uuxJFOaZs5U8eUlBdwLd7zz29eGcfRs3Facfh9T/NnJ5cRwdDvS
         KmUzn54iEsKsu2xCvUWjUMUmjkYzLR1Nu6n5Kx7t1jrIzCPsZkkx3Sv3pOov9fWXOtaU
         Ee8g==
X-Gm-Message-State: APjAAAVeG9Eran6CFcWA6iU8QVApJM2BcJAC6p1VXXHHwYk+x0TRGQwb
        p5bNtCQIB84cjFyk/zvgvA==
X-Google-Smtp-Source: APXvYqzkJVtsmAZGdGeqZM9cgu3uJE+vU03NBbc9q4BAapKFdd2bc55PSaWCVEKdbndFoe2bV1EQig==
X-Received: by 2002:a05:6830:22e2:: with SMTP id t2mr13583494otc.129.1581599050001;
        Thu, 13 Feb 2020 05:04:10 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id 32sm772548ott.38.2020.02.13.05.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:04:09 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e166:6491:dd75:4196])
        by serve.minyard.net (Postfix) with ESMTPSA id F047C180053;
        Thu, 13 Feb 2020 13:04:08 +0000 (UTC)
Date:   Thu, 13 Feb 2020 07:04:07 -0600
From:   Corey Minyard <minyard@acm.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Amol Grover <frextrite@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH v3] drivers: char: ipmi: ipmi_msghandler: Pass lockdep
 expression to RCU lists
Message-ID: <20200213130407.GQ7842@minyard.net>
Reply-To: minyard@acm.org
References: <20200117132521.31020-1-frextrite@gmail.com>
 <20200212134552.GN7842@minyard.net>
 <20200212214956.GT2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212214956.GT2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 01:49:56PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 12, 2020 at 07:45:52AM -0600, Corey Minyard wrote:
> > On Fri, Jan 17, 2020 at 06:55:22PM +0530, Amol Grover wrote:
> > > intf->cmd_rcvrs is traversed with list_for_each_entry_rcu
> > > outside an RCU read-side critical section but under the
> > > protection of intf->cmd_rcvrs_mutex.
> > > 
> > > ipmi_interfaces is traversed using list_for_each_entry_rcu
> > > outside an RCU read-side critical section but under the protection
> > > of ipmi_interfaces_mutex.
> > > 
> > > Hence, add the corresponding lockdep expression to the list traversal
> > > primitive to silence false-positive lockdep warnings, and
> > > harden RCU lists.
> > > 
> > > Add macro for the corresponding lockdep expression to make the code
> > > clean and concise.
> > > 
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > 
> > After reading everything, I think this is correct, but I would like
> > Paul's stamp of approval on this.
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> But note that I did not trace the locking in the case of ipmi_add_smi().
> I did the others, so lockdep can do the last one.  ;-)

Thanks, it's in my queue for 5.7.

-corey

> 
> 							Thanx, Paul
> 
> > Thanks,
> > 
> > -corey
> > 
> > > ---
> > > v3:
> > > - Remove rcu_read_lock_held() from lockdep expression since it is
> > >   implicitly checked.
> > > - Remove unintended macro usage.
> > >  
> > > v2:
> > > - Fix sparse error
> > >   CHECK: Alignment should match open parenthesis
> > > 
> > >  drivers/char/ipmi/ipmi_msghandler.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > > index cad9563f8f48..64ba16dcb681 100644
> > > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > > @@ -618,6 +618,8 @@ static DEFINE_MUTEX(ipmidriver_mutex);
> > >  
> > >  static LIST_HEAD(ipmi_interfaces);
> > >  static DEFINE_MUTEX(ipmi_interfaces_mutex);
> > > +#define ipmi_interfaces_mutex_held() \
> > > +	lockdep_is_held(&ipmi_interfaces_mutex)
> > >  static struct srcu_struct ipmi_interfaces_srcu;
> > >  
> > >  /*
> > > @@ -1321,7 +1323,8 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
> > >  	 * synchronize_srcu()) then free everything in that list.
> > >  	 */
> > >  	mutex_lock(&intf->cmd_rcvrs_mutex);
> > > -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> > > +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > > +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
> > >  		if (rcvr->user == user) {
> > >  			list_del_rcu(&rcvr->link);
> > >  			rcvr->next = rcvrs;
> > > @@ -1599,7 +1602,8 @@ static struct cmd_rcvr *find_cmd_rcvr(struct ipmi_smi *intf,
> > >  {
> > >  	struct cmd_rcvr *rcvr;
> > >  
> > > -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> > > +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > > +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
> > >  		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
> > >  					&& (rcvr->chans & (1 << chan)))
> > >  			return rcvr;
> > > @@ -1614,7 +1618,8 @@ static int is_cmd_rcvr_exclusive(struct ipmi_smi *intf,
> > >  {
> > >  	struct cmd_rcvr *rcvr;
> > >  
> > > -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> > > +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > > +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
> > >  		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
> > >  					&& (rcvr->chans & chans))
> > >  			return 0;
> > > @@ -3450,7 +3455,8 @@ int ipmi_add_smi(struct module         *owner,
> > >  	/* Look for a hole in the numbers. */
> > >  	i = 0;
> > >  	link = &ipmi_interfaces;
> > > -	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link) {
> > > +	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link,
> > > +				ipmi_interfaces_mutex_held()) {
> > >  		if (tintf->intf_num != i) {
> > >  			link = &tintf->link;
> > >  			break;
> > > -- 
> > > 2.24.1
> > > 
