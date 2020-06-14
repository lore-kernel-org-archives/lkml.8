Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705A42074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592114719;
	bh=2CSDwCSzFnYCIB4Swm1XflYFwYFE1DwSm8DZiH5VAhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cW15BIpLgrqyFfmDZgoR+PWM+281I/v+S17HZDVxuzIEYyRYMmTTTPqmvjPsgpvgD
	 HV/PdkM666u7aLt6xtU1hbfhByCMhzJStMQQ+PeVa8QnxioMDlEJL+iB7qUJWAWCMn
	 rqjIuW/3HsK1zR+WoBSRoVW1po8hHTYchRKay+RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFNGFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNGFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:05:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EACD72068E;
        Sun, 14 Jun 2020 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592114704;
        bh=2CSDwCSzFnYCIB4Swm1XflYFwYFE1DwSm8DZiH5VAhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ny5UCHwdApcnokCBTdXFaf8W81qxPwwfMoUizDWdc4hk1khnsFFu242s8gWg2LBnL
         NbcSXX/Qz90BOZFKIbKeGkAfnjdlPx16AroAv8AuGsA17DOTDChKwppgGzwvldeiRB
         le2OLPDPpo//8fAVkDlsTYu8lR3OPAd9QVe+yghM=
Date:   Sun, 14 Jun 2020 08:05:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 23/24] kset-example: add pr_debug()s for easy
 visibility of its operation
Message-ID: <20200614060501.GB2608744@kroah.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-24-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-24-jim.cromie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 09:57:37AM -0600, Jim Cromie wrote:
> put pr_debug()s into most functions, to easily see code operate when
> module is loaded and used.
> 
>   #> dmesg -w &
>   #> modprobe kset-example dyndbg=+pfml
>   #> cat /sys/kernel/kset-example/*/*
> ---
>  samples/kobject/kset-example.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
> index c8010f126808..27c9b1beec28 100644
> --- a/samples/kobject/kset-example.c
> +++ b/samples/kobject/kset-example.c
> @@ -56,6 +56,7 @@ static ssize_t foo_attr_show(struct kobject *kobj,
>  	struct foo_attribute *attribute;
>  	struct foo_obj *foo;
>  
> +	pr_debug("called");
>  	attribute = to_foo_attr(attr);
>  	foo = to_foo_obj(kobj);
>  
> @@ -76,6 +77,7 @@ static ssize_t foo_attr_store(struct kobject *kobj,
>  	struct foo_attribute *attribute;
>  	struct foo_obj *foo;
>  
> +	pr_debug("called");
>  	attribute = to_foo_attr(attr);
>  	foo = to_foo_obj(kobj);
>  
> @@ -102,6 +104,7 @@ static void foo_release(struct kobject *kobj)
>  {
>  	struct foo_obj *foo;
>  
> +	pr_debug("called");
>  	foo = to_foo_obj(kobj);
>  	kfree(foo);
>  }
> @@ -112,6 +115,7 @@ static void foo_release(struct kobject *kobj)
>  static ssize_t foo_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
>  			char *buf)
>  {
> +	pr_debug("called");
>  	return sprintf(buf, "%d\n", foo_obj->foo);
>  }
>  
> @@ -120,6 +124,7 @@ static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
>  {
>  	int ret;
>  
> +	pr_debug("called");
>  	ret = kstrtoint(buf, 10, &foo_obj->foo);
>  	if (ret < 0)
>  		return ret;
> @@ -140,6 +145,7 @@ static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
>  {
>  	int var;
>  
> +	pr_debug("called");
>  	if (strcmp(attr->attr.name, "baz") == 0)
>  		var = foo_obj->baz;
>  	else
> @@ -152,6 +158,7 @@ static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
>  {
>  	int var, ret;
>  
> +	pr_debug("called");
>  	ret = kstrtoint(buf, 10, &var);
>  	if (ret < 0)
>  		return ret;
> @@ -201,6 +208,7 @@ static struct foo_obj *create_foo_obj(const char *name)
>  	struct foo_obj *foo;
>  	int retval;
>  
> +	pr_debug("called");
>  	/* allocate the memory for the whole object */
>  	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
>  	if (!foo)
> @@ -235,11 +243,13 @@ static struct foo_obj *create_foo_obj(const char *name)
>  
>  static void destroy_foo_obj(struct foo_obj *foo)
>  {
> +	pr_debug("called");
>  	kobject_put(&foo->kobj);
>  }
>  
>  static int __init example_init(void)
>  {
> +	pr_debug("called");

Why???  If you want to do something like this, use ftrace, that is what
it is for.

thanks,

greg k-h
