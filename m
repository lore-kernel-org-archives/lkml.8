Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6826C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D9A20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593670295;
	bh=qYyb3XvMu1qInzSVEF5ixtCaejjLK/A5G+yBok4qSWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tVVSW8g7GhYBpUVGqKpjyxwLIJPEl089qACmuXPsunZxnZrHTLNQLH3QjnqoXvjGw
	 PjoT0k3slJnhfrJ68niJlmPUFgwbuPO6MDIBnr/HvEXg2e0w44B/Eig4fnm17hQgxx
	 7s4JvVe+qLDZ5AAjKXDIzFUW7QozQb5kx/f6Lu8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGBGLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgGBGLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:11:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E4F2077D;
        Thu,  2 Jul 2020 06:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593670292;
        bh=qYyb3XvMu1qInzSVEF5ixtCaejjLK/A5G+yBok4qSWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGED+dE0lu+8h2pd40OzjkfKdrnM3qg5IDZUl1DJM5hsk3A5K5kuJkWuB98/ATtvT
         1GLcppZKhr97w+cJK9ovKjUwZyu5p6o2HC6J66ulpxI+iSP8lHDgtvZEaTf9XoGqZ3
         n2SrzyAzhbBDQ8ZilEMYCOx4ia+6pdwpAs4N3JWw=
Date:   Thu, 2 Jul 2020 08:11:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200702061136.GA679876@kroah.com>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <3b665cbd-7afb-b72d-22c0-7dc1543ac42e@amd.com>
 <BY5PR12MB37780DF07B437B9FFD1BB344F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB37780DF07B437B9FFD1BB344F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:48:43AM +0000, S, Shirish wrote:
> Hi All,
> 
> Can we land this patch upstream?

What patch?

> Feel free to add my tested-by.

Please send it in a form that I can add it, to the patch in question.

thanks,

greg k-h
