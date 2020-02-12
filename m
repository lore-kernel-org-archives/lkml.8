Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3F5C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F29E21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581544200;
	bh=LPjM60eQv8EtzXOT2YUg9BXx/0uoNBO7Jj/3xF05eBY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=iJZuxoI4v/jq27rDy+VtUwBNOhn+suQqiI8b9NY0Pdb5heYCsz/mTQTxf6HLhg6Au
	 qXxw1w3Td0WanLtVcpi8O+4tpN4UETabAdR0Gw/XLzcjoeqeOvb3TRQcuj0j8lcHxp
	 n9G6DX/fyo4WhU4z5OVtzvS0mgRWEiDnKBdGUIMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgBLVt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgBLVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:49:59 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5674206DB;
        Wed, 12 Feb 2020 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581544197;
        bh=LPjM60eQv8EtzXOT2YUg9BXx/0uoNBO7Jj/3xF05eBY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uyAwzvx2h/Y/aOHrzUq8wWwPpCGBrY5p9R+FhoOHMh5ehPS7KmcFRMSZUVcMLDn2/
         hvJAgnD0kgDkrQfRDr5vOU3rT+S6P2Wx9mOXWbrwnxn89u1MOnW5qiIZZsoG0StAzq
         68kBjb3p/DRi9z9fD9kPTFyWY2/NA0hKr8wvGSnA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2E2EF3522725; Wed, 12 Feb 2020 13:49:56 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:49:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Amol Grover <frextrite@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH v3] drivers: char: ipmi: ipmi_msghandler: Pass lockdep
 expression to RCU lists
Message-ID: <20200212214956.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200117132521.31020-1-frextrite@gmail.com>
 <20200212134552.GN7842@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212134552.GN7842@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:45:52AM -0600, Corey Minyard wrote:
> On Fri, Jan 17, 2020 at 06:55:22PM +0530, Amol Grover wrote:
> > intf->cmd_rcvrs is traversed with list_for_each_entry_rcu
> > outside an RCU read-side critical section but under the
> > protection of intf->cmd_rcvrs_mutex.
> > 
> > ipmi_interfaces is traversed using list_for_each_entry_rcu
> > outside an RCU read-side critical section but under the protection
> > of ipmi_interfaces_mutex.
> > 
> > Hence, add the corresponding lockdep expression to the list traversal
> > primitive to silence false-positive lockdep warnings, and
> > harden RCU lists.
> > 
> > Add macro for the corresponding lockdep expression to make the code
> > clean and concise.
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> 
> After reading everything, I think this is correct, but I would like
> Paul's stamp of approval on this.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

But note that I did not trace the locking in the case of ipmi_add_smi().
I did the others, so lockdep can do the last one.  ;-)

							Thanx, Paul

> Thanks,
> 
> -corey
> 
> > ---
> > v3:
> > - Remove rcu_read_lock_held() from lockdep expression since it is
> >   implicitly checked.
> > - Remove unintended macro usage.
> >  
> > v2:
> > - Fix sparse error
> >   CHECK: Alignment should match open parenthesis
> > 
> >  drivers/char/ipmi/ipmi_msghandler.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index cad9563f8f48..64ba16dcb681 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -618,6 +618,8 @@ static DEFINE_MUTEX(ipmidriver_mutex);
> >  
> >  static LIST_HEAD(ipmi_interfaces);
> >  static DEFINE_MUTEX(ipmi_interfaces_mutex);
> > +#define ipmi_interfaces_mutex_held() \
> > +	lockdep_is_held(&ipmi_interfaces_mutex)
> >  static struct srcu_struct ipmi_interfaces_srcu;
> >  
> >  /*
> > @@ -1321,7 +1323,8 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
> >  	 * synchronize_srcu()) then free everything in that list.
> >  	 */
> >  	mutex_lock(&intf->cmd_rcvrs_mutex);
> > -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> > +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
> >  		if (rcvr->user == user) {
> >  			list_del_rcu(&rcvr->link);
> >  			rcvr->next = rcvrs;
> > @@ -1599,7 +1602,8 @@ static struct cmd_rcvr *find_cmd_rcvr(struct ipmi_smi *intf,
> >  {
> >  	struct cmd_rcvr *rcvr;
> >  
> > -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> > +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
> >  		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
> >  					&& (rcvr->chans & (1 << chan)))
> >  			return rcvr;
> > @@ -1614,7 +1618,8 @@ static int is_cmd_rcvr_exclusive(struct ipmi_smi *intf,
> >  {
> >  	struct cmd_rcvr *rcvr;
> >  
> > -	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
> > +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
> > +				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
> >  		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
> >  					&& (rcvr->chans & chans))
> >  			return 0;
> > @@ -3450,7 +3455,8 @@ int ipmi_add_smi(struct module         *owner,
> >  	/* Look for a hole in the numbers. */
> >  	i = 0;
> >  	link = &ipmi_interfaces;
> > -	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link) {
> > +	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link,
> > +				ipmi_interfaces_mutex_held()) {
> >  		if (tintf->intf_num != i) {
> >  			link = &tintf->link;
> >  			break;
> > -- 
> > 2.24.1
> > 
