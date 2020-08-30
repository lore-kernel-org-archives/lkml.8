Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E11C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 00:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9218D2076D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 00:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgH3AoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 20:44:03 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:43662 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728246AbgH3AoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 20:44:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 61C8737F1;
        Sun, 30 Aug 2020 00:44:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wine80_5804e8727082
X-Filterd-Recvd-Size: 7121
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Aug 2020 00:43:59 +0000 (UTC)
Message-ID: <c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com>
Subject: Re: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 17:43:58 -0700
In-Reply-To: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
References: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 16:48 -0700, Joe Perches wrote:
> Output defects can exist in sysfs content using sprintf and snprintf.
> 
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length.
> 
> Add a generic sysfs_emit function that knows that the size of the
> temporary buffer and ensures that no overrun is done.
> 
> Add a generic sysfs_emit_at function that can be used in multiple
> call situations that also ensures that no overrun is done.

This preliminary coccinelle script converts ~5000 instances treewide.
There are still many remaining instances that could be converted.

$ git grep -w sysfs_emit -- '*.[ch]'|wc -l
4702
$ git grep -w sysfs_emit_at -- '*.[ch]'|wc -l
229

$ cat sysfs_emit.cocci
@@
identifier d_show =~ "^.*show.*$";
identifier arg1, arg2, arg3;
@@
ssize_t d_show(struct device *
-	arg1
+	dev
	, struct device_attribute *
-	arg2
+	attr
	, char *
-	arg3
+	buf
	)
{
	...
(
-	arg1
+	dev
|
-	arg2
+	attr
|
-	arg3
+	buf
)
	...
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}

@@
identifier k_show =~ "^.*show.*$";
identifier arg1, arg2, arg3;
@@
ssize_t k_show(struct kobject *
-	arg1
+	kobj
	, struct kobj_attribute *
-	arg2
+	attr
	, char *
-	arg3
+	buf
	)
{
	...
(
-	arg1
+	kobj
|
-	arg2
+	attr
|
-	arg3
+	buf
)
	...
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
expression chr;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
expression chr;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}


