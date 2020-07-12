Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91933C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624DB2063A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="sEDKjswb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgGLVKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:10:05 -0400
Received: from mail.nic.cz ([217.31.204.67]:37952 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbgGLVKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:10:05 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 9B0851409F2;
        Sun, 12 Jul 2020 23:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594588201; bh=AXsAQ00im1dBSWjGHBbi6ub/aO46gj06mSMMisx+SwU=;
        h=Date:From:To;
        b=sEDKjswbXXkqD7crJCA/YWAVNrdRpg2PyC+qSfzaZHrkU5GDwjusXbZDgvyAtake5
         hDF2K35lkRCr//rcLV3yVeLUuKlWdggbOJRXm9tv6aRnycDXtlMH1R65MbEZksebtk
         i2VOf19aHhVfeay6ijw9q/+Sje+o+6Ph7zOIxFL0=
Date:   Sun, 12 Jul 2020 23:10:01 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?T25kxZllag==?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH RFC] leds: Add support for per-LED device triggers
Message-ID: <20200712231001.7c1060e4@nic.cz>
In-Reply-To: <20200712191111.GA20592@amd>
References: <20200702144712.1994685-1-megous@megous.com>
        <20200711100409.GA18901@amd>
        <20200711210111.5ysijhexgyzyr7u7@core.my.home>
        <20200712072554.GC4721@duo.ucw.cz>
        <20200712134911.r3lig4hgyqhmslth@core.my.home>
        <20200712191111.GA20592@amd>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jul 2020 21:11:11 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > > > > Some LED controllers may come with an internal HW triggering mechanism
> > > > > > for the LED and an ability to switch between user control of the LED,
> > > > > > or the internal control. One such example is AXP20X PMIC, that allows
> > > > > > wither for user control of the LED, or for internal control based on
> > > > > > the state of the battery charger.
> > > > > > 
> > > > > > Add support for registering per-LED device trigger.
> > > > > > 
> > > > > > Names of private triggers need to be globally unique, but may clash
> > > > > > with other private triggers. This is enforced during trigger
> > > > > > registration. Developers can register private triggers just like
> > > > > > the normal triggers, by setting private_led to a classdev
> > > > > > of the LED the trigger is associated with.  
> > > > > 
> > > > > What about this? Should address Marek's concerns about resource use...  
> > > > 
> > > > What concerns? Marek's concerns seem to be about case where we register
> > > > a trigger for (each led * self-working configuration) which I admit
> > > > can be quite a lot of triggers if there are many functions. But that's
> > > > not my proposal.
> > > > 
> > > > My proposal is to only register on trigger per LED at most. So on my
> > > > system that's 1 extra trigger and on Marek's system that'd be 48 new
> > > > triggers. Neither seems like a meaningful problem from resource
> > > > use perspective.  
> > > 
> > > So.. 48 triggers on Marek's systems means I'll not apply your patch.
> > > 
> > > Please take a look at my version, it is as simple and avoids that
> > > problem.  
> > 
> > I would, but I don't see your version linked or mentioned in this
> > thread.  
> 
> Ah! Sorry about that. Here it is. (I verified it compiles in the
> meantime).
> 
> Best regards,
> 								Pavel
> 
> diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
> index 79e30d2cb7a5..e8333675959c 100644
> --- a/drivers/leds/led-triggers.c
> +++ b/drivers/leds/led-triggers.c
> @@ -27,6 +27,12 @@ LIST_HEAD(trigger_list);
>  
>   /* Used by LED Class */
>  
> +static inline bool
> +trigger_relevant(struct led_classdev *led_cdev, struct led_trigger *trig)
> +{
> +	return !trig->trigger_type || trig->trigger_type == led_cdev->trigger_type;
> +}
> +
>  ssize_t led_trigger_write(struct file *filp, struct kobject *kobj,
>  			  struct bin_attribute *bin_attr, char *buf,
>  			  loff_t pos, size_t count)
> @@ -50,7 +56,8 @@ ssize_t led_trigger_write(struct file *filp, struct kobject *kobj,
>  
>  	down_read(&triggers_list_lock);
>  	list_for_each_entry(trig, &trigger_list, next_trig) {
> -		if (sysfs_streq(buf, trig->name)) {
> +		if (sysfs_streq(buf, trig->name) &&
> +		    trigger_relevant(led_cdev, trig)) {
>  			down_write(&led_cdev->trigger_lock);
>  			led_trigger_set(led_cdev, trig);
>  			up_write(&led_cdev->trigger_lock);
> @@ -96,6 +103,9 @@ static int led_trigger_format(char *buf, size_t size,
>  		bool hit = led_cdev->trigger &&
>  			!strcmp(led_cdev->trigger->name, trig->name);
>  
> +		if (!trigger_relevant(led_cdev, trig))
> +			continue;
> +
>  		len += led_trigger_snprintf(buf + len, size - len,
>  					    " %s%s%s", hit ? "[" : "",
>  					    trig->name, hit ? "]" : "");
> @@ -243,7 +253,8 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
>  	down_read(&triggers_list_lock);
>  	down_write(&led_cdev->trigger_lock);
>  	list_for_each_entry(trig, &trigger_list, next_trig) {
> -		if (!strcmp(led_cdev->default_trigger, trig->name)) {
> +		if (!strcmp(led_cdev->default_trigger, trig->name) &&
> +		    trigger_relevant(led_cdev, trig)) {
>  			led_cdev->flags |= LED_INIT_DEFAULT_TRIGGER;
>  			led_trigger_set(led_cdev, trig);
>  			break;
> @@ -280,7 +291,8 @@ int led_trigger_register(struct led_trigger *trig)
>  	down_write(&triggers_list_lock);
>  	/* Make sure the trigger's name isn't already in use */
>  	list_for_each_entry(_trig, &trigger_list, next_trig) {
> -		if (!strcmp(_trig->name, trig->name)) {
> +		if (!strcmp(_trig->name, trig->name) &&
> +		    (!_trig->private_led || _trig->private_led == trig->private_led)) {
>  			up_write(&triggers_list_lock);
>  			return -EEXIST;
>  		}
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 2451962d1ec5..cba52714558f 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -57,6 +57,10 @@ struct led_init_data {
>  	bool devname_mandatory;
>  };
>  
> +struct led_hw_trigger_type {
> +	int dummy;
> +}
> +
>  struct led_classdev {
>  	const char		*name;
>  	enum led_brightness	 brightness;
> @@ -150,6 +154,8 @@ struct led_classdev {
>  
>  	/* Ensures consistent access to the LED Flash Class device */
>  	struct mutex		led_access;
> +
> +	struct led_hw_trigger_type *trigger_type;
>  };
>  
>  /**
> @@ -345,6 +351,9 @@ struct led_trigger {
>  	int		(*activate)(struct led_classdev *led_cdev);
>  	void		(*deactivate)(struct led_classdev *led_cdev);
>  
> +	/* LED-private triggers have this set. */
> +	struct led_hw_trigger_type *trigger_type;
> +
>  	/* LEDs under control by this trigger (for simple triggers) */
>  	rwlock_t	  leddev_list_lock;
>  	struct list_head  led_cdevs;
> 

Hmm, this could actually work and is nicer than my proposal, since it
does not require to differentiate between a HW and SW trigger when
changing them.

Marek
