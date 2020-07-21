Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA62C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61031206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGUCAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:00:24 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:38822 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgGUCAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:00:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3BA2118020C26;
        Tue, 21 Jul 2020 02:00:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheep38_3d1250f26f29
X-Filterd-Recvd-Size: 2277
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Jul 2020 02:00:21 +0000 (UTC)
Message-ID: <b38a439b2bdd1122805aa182da9a1802e673f53e.camel@perches.com>
Subject: Re: [PATCH] ipmi/watchdog: add missing newlines when printing
 parameters by sysfs
From:   Joe Perches <joe@perches.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Date:   Mon, 20 Jul 2020 19:00:20 -0700
In-Reply-To: <908fcbf2-efbb-b3f4-0666-2da79fbe99c4@huawei.com>
References: <1595210605-27888-1-git-send-email-wangxiongfeng2@huawei.com>
         <20200720195234.GC2952@minyard.net>
         <908fcbf2-efbb-b3f4-0666-2da79fbe99c4@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 09:20 +0800, Xiongfeng Wang wrote:
> On 2020/7/21 3:52, Corey Minyard wrote:
> > On Mon, Jul 20, 2020 at 10:03:25AM +0800, Xiongfeng Wang wrote:
> > > When I cat some ipmi_watchdog parameters by sysfs, it displays as
> > > follows. It's better to add a newline for easy reading.
[]
> > > diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
[]
> > > @@ -232,12 +232,16 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
> > >  static int get_param_str(char *buffer, const struct kernel_param *kp)
> > >  {
> > >  	action_fn fn = (action_fn) kp->arg;
> > > -	int       rv;
> > > +	int rv, len;
> > >  
> > >  	rv = fn(NULL, buffer);
> > >  	if (rv)
> > >  		return rv;
> > > -	return strlen(buffer);
> > > +
> > > +	len = strlen(buffer);
> > > +	len += sprintf(buffer + len, "\n");
> > 
> > sprintf is kind of overkill to stick a \n on the end of a line.  How
> > about:
> > 
> > 	buffer[len++] = '\n';
> > 
> > Since you are returning the length, you shouldn't need to nil terminate
> > the string.

You never quite know for sure so I suggest making
the string null terminated just in case.

i.e.:

	buffer[len++] = '\n';
	buffer[len] = 0;


