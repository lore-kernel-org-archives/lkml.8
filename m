Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA2C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A647C2076D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgH3I7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:59:44 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:18271 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgH3I7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:59:43 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="465246587"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 10:59:41 +0200
Date:   Sun, 30 Aug 2020 10:59:40 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
In-Reply-To: <c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008301059080.3629@hadrien>
References: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com> <c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Aug 2020, Joe Perches wrote:

> On Sat, 2020-08-29 at 16:48 -0700, Joe Perches wrote:
> > Output defects can exist in sysfs content using sprintf and snprintf.
> >
> > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > used for outputting sysfs content and it's possible to overrun the
> > PAGE_SIZE buffer length.
> >
> > Add a generic sysfs_emit function that knows that the size of the
> > temporary buffer and ensures that no overrun is done.
> >
> > Add a generic sysfs_emit_at function that can be used in multiple
> > call situations that also ensures that no overrun is done.
>
> This preliminary coccinelle script converts ~5000 instances treewide.
> There are still many remaining instances that could be converted.

Except for the issue with the ...s that has been discussed, this looks
basically reasonable to me.

julia


>
> $ git grep -w sysfs_emit -- '*.[ch]'|wc -l
> 4702
> $ git grep -w sysfs_emit_at -- '*.[ch]'|wc -l
> 229
>
> $ cat sysfs_emit.cocci
> @@
> identifier d_show =~ "^.*show.*$";
> identifier arg1, arg2, arg3;
> @@
> ssize_t d_show(struct device *
> -	arg1
> +	dev
> 	, struct device_attribute *
> -	arg2
> +	attr
> 	, char *
> -	arg3
> +	buf
> 	)
> {
> 	...
> (
> -	arg1
> +	dev
> |
> -	arg2
> +	attr
> |
> -	arg3
> +	buf
> )
> 	...
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	sprintf(buf,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	snprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	scnprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> expression chr;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	strcpy(buf, chr);
> +	sysfs_emit(buf, chr);
> 	...>
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> identifier len;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	len =
> -	sprintf(buf,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> identifier len;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	len =
> -	snprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> identifier len;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	len =
> -	scnprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> identifier len;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> -	len += scnprintf(buf + len, PAGE_SIZE - len,
> +	len += sysfs_emit_at(buf, len,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier d_show =~ "^.*show.*$";
> identifier dev, attr, buf;
> expression chr;
> @@
>
> ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> -	strcpy(buf, chr);
> -	return strlen(buf);
> +	return sysfs_emit(buf, chr);
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier arg1, arg2, arg3;
> @@
> ssize_t k_show(struct kobject *
> -	arg1
> +	kobj
> 	, struct kobj_attribute *
> -	arg2
> +	attr
> 	, char *
> -	arg3
> +	buf
> 	)
> {
> 	...
> (
> -	arg1
> +	kobj
> |
> -	arg2
> +	attr
> |
> -	arg3
> +	buf
> )
> 	...
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	sprintf(buf,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	snprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	scnprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> expression chr;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> 	return
> -	strcpy(buf, chr);
> +	sysfs_emit(buf, chr);
> 	...>
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> 	len =
> -	sprintf(buf,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> 	len =
> -	snprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> 	len =
> -	scnprintf(buf, PAGE_SIZE,
> +	sysfs_emit(buf,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> 	<...
> -	len += scnprintf(buf + len, PAGE_SIZE - len,
> +	len += sysfs_emit_at(buf, len,
> 	...);
> 	...>
> 	return len;
> }
>
> @@
> identifier k_show =~ "^.*show.*$";
> identifier kobj, attr, buf;
> expression chr;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
> -	strcpy(buf, chr);
> -	return strlen(buf);
> +	return sysfs_emit(buf, chr);
> }
>
>
>
