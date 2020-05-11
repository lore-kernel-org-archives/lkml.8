Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE91C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED1220708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3mf3ZJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgEKQrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgEKQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:47:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B98EC061A0C;
        Mon, 11 May 2020 09:47:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so4990949pfx.6;
        Mon, 11 May 2020 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZxZ+LNXooelMFfSlZpAdADZ0tj2CGMfXwem7tyyyZjI=;
        b=B3mf3ZJX5nxwKQ2JbRXP4UhMcFX9MMg5WxhA4VsAKC716/NMaJlz3yhHmf8UXF3y5G
         bedq/2c6b6izlX2O+6bi1cI6UY5PNDBZCahFmlxHt/3ni+7re4QJUdL5Nh6w5bnbmhq2
         EEnPbKQ5rdlDTXs6ikWRuODeKQAZKuQYq41SYPF5tYjE8Uw4PnnDSWy03HYdpD72b+bC
         r58Er9/0sH/bkSzgMO2fbv8EmgjWhe5/7b45xdjZqPQv5lYgcGKibmZkPDD5fMukkbA+
         MQIBmEF4NdanPLXZYyHqzKHV2ynKy16F+yAjcb5S9+E43aYFintrYSMHNK43B3e1S2Vi
         8OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ZxZ+LNXooelMFfSlZpAdADZ0tj2CGMfXwem7tyyyZjI=;
        b=cMk9w5aYR0sjSWyGMw0Qh6iCOvUEdZUporOatxat1w1uJg+XKrdqWP03QGHaj0QhbZ
         idBZrptf7sLv7FbiEkBZXXjQqRRnrGnQntef+enJoJgii01vV5unVekLJo6Qj3z8F4az
         HarD6/1DIkG0eOlW/M1jSpUY7AvrdwiPVQU+G8Y4iAmIrYmwIH+dJQiUKBcH6UjMzblc
         P8RSxhj/z89TLJyARn5sm8D4pOCz1EC1Njwz3mVi49GYE7jv0y7VkvZoqcvVCTknzAQq
         oWTjOmmNI6fqUG28D30I+f59Xi3ZEuA/KjQqsHk54EPgxtxQSZvSy7ObQS1uUDip9/43
         bQYA==
X-Gm-Message-State: AGi0PuZe+CRtFbFlGi++DK72LWpdZuLIjwpZrLPggVHcloQSxP3TLX0l
        1VCC7c2t1ltIzO6ITMibdO41H7PB
X-Google-Smtp-Source: APiQypK7eD9kXLOTKh+SfZrSfG2VJdbSxL4HhJuz4L/E1u/xFnHuKDTd78vaQ5iy2sTAb+0F+SCnJA==
X-Received: by 2002:a65:6709:: with SMTP id u9mr15969426pgf.386.1589215655967;
        Mon, 11 May 2020 09:47:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cp22sm10612435pjb.28.2020.05.11.09.47.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 09:47:35 -0700 (PDT)
Date:   Mon, 11 May 2020 09:47:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     zhouchuangao <chuangaozhou@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Subject: Re: [PATCH] driver/hwmon/nct6775: Use kobj_to_dev() API
Message-ID: <20200511164734.GA23709@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:43:06AM +0800, zhouchuangao wrote:
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: zhouchuangao <zhouchuangao@xiaomi.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6775.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 7efa6bf..e7e1ddc 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -2047,7 +2047,7 @@ store_temp_beep(struct device *dev, struct device_attribute *attr,
>  static umode_t nct6775_in_is_visible(struct kobject *kobj,
>  				     struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6775_data *data = dev_get_drvdata(dev);
>  	int in = index / 5;	/* voltage index */
>  
> @@ -2253,7 +2253,7 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
>  static umode_t nct6775_fan_is_visible(struct kobject *kobj,
>  				      struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6775_data *data = dev_get_drvdata(dev);
>  	int fan = index / 6;	/* fan index */
>  	int nr = index % 6;	/* attribute index */
> @@ -2440,7 +2440,7 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
>  static umode_t nct6775_temp_is_visible(struct kobject *kobj,
>  				       struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6775_data *data = dev_get_drvdata(dev);
>  	int temp = index / 10;	/* temp index */
>  	int nr = index % 10;	/* attribute index */
> @@ -3257,7 +3257,7 @@ store_auto_temp(struct device *dev, struct device_attribute *attr,
>  static umode_t nct6775_pwm_is_visible(struct kobject *kobj,
>  				      struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6775_data *data = dev_get_drvdata(dev);
>  	int pwm = index / 36;	/* pwm index */
>  	int nr = index % 36;	/* attribute index */
> @@ -3459,7 +3459,7 @@ static SENSOR_DEVICE_ATTR(beep_enable, S_IWUSR | S_IRUGO, show_beep,
>  static umode_t nct6775_other_is_visible(struct kobject *kobj,
>  					struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct6775_data *data = dev_get_drvdata(dev);
>  
>  	if (index == 0 && !data->have_vid)
> -- 
> 2.7.4
> 
