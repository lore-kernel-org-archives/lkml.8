Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA27C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BF32080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5asr7il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgAMK6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:58:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbgAMK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578913127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAIEx8cHnHOVRlTiWsQtbwI/8/to6aYjrn2aGGLywaU=;
        b=O5asr7ilB+nzkEeDKcpd2Y5KJwdIlRB2xFjXN+xUcfZdYX5zMOuTrq2i8PZ1fxOzod0VSO
        nPwGsALdx3mX9RIxXXeKp0hrzq3lgn9G1Eme3/DhJZBnKxsqWPtE2pZyqLjIqOEygEZre9
        7/p47FxTQsJ+zrS6gb0lyxeYs1ffitM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-w6u5EupMOUOV-0T5fN4k_Q-1; Mon, 13 Jan 2020 05:58:44 -0500
X-MC-Unique: w6u5EupMOUOV-0T5fN4k_Q-1
Received: by mail-wr1-f72.google.com with SMTP id f15so4885559wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MAIEx8cHnHOVRlTiWsQtbwI/8/to6aYjrn2aGGLywaU=;
        b=dFX/lwF0NzTffJBV4HtojrIEawBFpxaYhJo1m4gAPaXFgAgkNyGWzQd4Fc8Pn09bH8
         H4cXCNsp9WjIz6qONC9M6khX27MmXnZLsxyy7eot3E+8kp7endiAV0hPGp2pbGQuNH+8
         5TRZJ532LAVTIqm5+a+W3931UF0MKfxaUHCEQ09BGQoqplBF/Ghs/rP8hOvbMekUmhwl
         cqN7TchYQoKXqCVjLnXK/biLlkbZxeKcqLh03fzI/LH/i5I0rC5OzLNDxhj+bTNlBL4n
         6xp9WS65l3L/gzgx395tUf85i8f3MOCo36SXGa4Vld/LHvRalKdTFU6WLaSfkBTiCIYL
         c0sg==
X-Gm-Message-State: APjAAAXY+s39aP2L+zItyrUV8cPodeXtICFrTCsQW/g+rh4spk/Utlh/
        NvJ2GEZiRCbHujuLxmlmeLLUyAU20KPvYu9yj3sUt24CYB2b62KcK3VzT/rrC1DOLcUnKCNbyVr
        tLUxBjD822O718PUV+RvFbGaw
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr17776287wrr.116.1578913123559;
        Mon, 13 Jan 2020 02:58:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0X+GCNnIYMa9/uyFL3BntxkkCxwnCzMMKnBBjLzSQeAoUow1Y6WTCKG6G63ALbSxLbBAaQQ==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr17776251wrr.116.1578913123227;
        Mon, 13 Jan 2020 02:58:43 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x11sm14953648wre.68.2020.01.13.02.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 02:58:41 -0800 (PST)
Subject: Re: [PATCH 1/3] Input: axp20x-pek - Remove unique wakeup event
 handling
From:   Hans de Goede <hdegoede@redhat.com>
To:     Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200113032032.38709-1-samuel@sholland.org>
 <6c876812-6ec1-cf28-8ce4-7732c5cf67da@redhat.com>
Message-ID: <22828711-7e60-a0cb-4ac9-e7c6d6aff080@redhat.com>
Date:   Mon, 13 Jan 2020 11:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <6c876812-6ec1-cf28-8ce4-7732c5cf67da@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-2020 11:41, Hans de Goede wrote:
> Hi,
> 
> On 13-01-2020 04:20, Samuel Holland wrote:
>> This driver attempts to avoid reporting wakeup events to userspace by
>> clearing a possible pending IRQ before IRQs are enabled during resume.
>> The assumption seems to be that userspace cannot cope with a KEY_POWER
>> press during resume. However, no other input driver does this, so it
>> would be a bug that such events are missing with this driver.
>>
>> Furthermore, for PMICs connected via I2C or RSB, it is not possible to
>> update the regmap during the noirq resume phase, because the bus
>> controller drivers require IRQs to perform bus transactions. And the
>> resume hook cannot move to a later phase, because then it would race
>> with the power key IRQ handler.
>>
>> So the best solution seems to be simply removing the hook.
> 
> Hmm, I'm not sure this is a good idea, let me give you some background
> info on this:
> 
> This hook was handled because on X86 systems/laptops when waking
> them up typically the power-button does not send a KEY_POWER press event
> when the system was woken up through the power-button.
> 
> So normal (e.g. Debian, Fedora) userspace does not expect this event
> and will directly go to sleep again because that is the default behavior
> on a KEY_POWER event.

p.s.

The main reason why typical userspace does not expect the KEY_POWER
event is because most of the devices which run mainline and have
suspend/resume working and are using the ACPI button driver for
the power-button: drivers/acpi/button.c, which has:

                         acpi_pm_wakeup_event(&device->dev);
                         if (button->suspended)
                                 break;

                         keycode = test_bit(KEY_SLEEP, input->keybit) ?
                                                 KEY_SLEEP : KEY_POWER;
                         input_report_key(input, keycode, 1);
                         input_sync(input);
                         input_report_key(input, keycode, 0);
                         input_sync(input);

And:

static int acpi_button_suspend(struct device *dev)
{
         struct acpi_device *device = to_acpi_device(dev);
         struct acpi_button *button = acpi_driver_data(device);

         button->suspended = true;
         return 0;
}

static int acpi_button_resume(struct device *dev)
{
         struct acpi_device *device = to_acpi_device(dev);
         struct acpi_button *button = acpi_driver_data(device);

         button->suspended = false;
         return 0;
}

So when the ACPI notify for the button runs on resume, suspended is
still true; and no KEY_POWER event is send...

Arguably to be consistent we should fix drivers/acpi/button.c to
send KEY_POWER on wakeup too, but that will break things for many
users with a likelyhood of breakage approaching 100%.

Note I'm not telling this to argue against your change, just as
background for why I added this behavior to the axp20x-pek code.

Oh and taking a second look, I see that the hook is already
written so as to only execute on the AXP288 PMIC, which means
it should effectively already only influence X86 machines.

So are you trying to get the KEY_POWER event after wakeup
by power-button to work on a X86 device ?  In that case please
be aware of the drivers/acpi/button.c issue...

I have the feeling that we may need a Kconfig option to configure
whether or not to send KEY_POWER on wakeup by power-button, because
as discussed in my previous mail Android wants this, KDE/MATE/GNOME
not so much...

Regards,

Hans



> 
> On x86 axp20x-pek is only used for the power-button on Bay Trail devices
> with a AXP288 PMIC. On Cherry Trail devices with an AXP288 PMIC the
> power-button is also connected directly to a GPIO on the SoC and that
> is used (also see the axp20x_pek_should_register_input function).
> 
> So after writing this patch, when doing hw-enablement for the power-button
> on the Cherry Trail devices I learned that the gpio_keys driver does
> send userspace a KEY_POWER event when woken up with the power-button.
> 
> I wrote a patch for gpio-keys to not do this, as that is what normal
> Linux userspace expects, but that was nacked, because under e.g.
> Android the KEY_POWER event is actually desirable / necessary to avoid
> Android immediately re-suspending the system again. Since my "fix" to
> the gpio-keys devices was nacked I have instead wroked around this in
> userspace, but *only* for the GNOME3 desktop environment, by teaching
> GNOME3 to ignore KEY_POWER events for the first couple of seconds after
> a resume.
> 
> So your suggested change, which will cause KEY_POWER to be send on
> Bay Trail devices after a wake-up by the power button, should be
> fine for recent GNOME3 versions, but for other desktop environments
> this may cause a regression where they respond to the new KEY_POWER
> event by immediately going back to sleep again.
> 
> As for this not working with the i2c bus, it does on X86 because
> the PMIC is also directly accessed by the power-management HW of
> the SoC and to make this work the i2c-controller is never suspended
> and its irq is marked IRQF_NO_SUSPEND. But this is X86 special
> sauce.
> 
> Summarizing:
> 
> I'm personally fine with remove the magic I added to suppress
> the KEY_POWER press reporting as in hindsight given the gpio-keys
> story I should have never added it. But I'm worried about this
> causing regressions for some Bay Trail users. OTOH making this
> change would be good for Android X86 users.
> 
> Another IMHO better fix would be to drop the __maybe_unused and
> instead wrap both the axp20x_pek_resume_noirq function and the
> init of the  .resume_noirq struct member with:
> 
> #if defined X86 && defined CONFIG_PM_SLEEP
> 
> This keeps the current behavior on Bay Trail machines, while
> I assume it should also fix the issues this was causing for
> your setup.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>   drivers/input/misc/axp20x-pek.c | 25 -------------------------
>>   1 file changed, 25 deletions(-)
>>
>> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
>> index 17c1cca74498..7d0ee5bececb 100644
>> --- a/drivers/input/misc/axp20x-pek.c
>> +++ b/drivers/input/misc/axp20x-pek.c
>> @@ -352,30 +352,6 @@ static int axp20x_pek_probe(struct platform_device *pdev)
>>       return 0;
>>   }
>> -static int __maybe_unused axp20x_pek_resume_noirq(struct device *dev)
>> -{
>> -    struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
>> -
>> -    if (axp20x_pek->axp20x->variant != AXP288_ID)
>> -        return 0;
>> -
>> -    /*
>> -     * Clear interrupts from button presses during suspend, to avoid
>> -     * a wakeup power-button press getting reported to userspace.
>> -     */
>> -    regmap_write(axp20x_pek->axp20x->regmap,
>> -             AXP20X_IRQ1_STATE + AXP288_IRQ_POKN / 8,
>> -             BIT(AXP288_IRQ_POKN % 8));
>> -
>> -    return 0;
>> -}
>> -
>> -static const struct dev_pm_ops axp20x_pek_pm_ops = {
>> -#ifdef CONFIG_PM_SLEEP
>> -    .resume_noirq = axp20x_pek_resume_noirq,
>> -#endif
>> -};
>> -
>>   static const struct platform_device_id axp_pek_id_match[] = {
>>       {
>>           .name = "axp20x-pek",
>> @@ -394,7 +370,6 @@ static struct platform_driver axp20x_pek_driver = {
>>       .id_table    = axp_pek_id_match,
>>       .driver        = {
>>           .name        = "axp20x-pek",
>> -        .pm        = &axp20x_pek_pm_ops,
>>           .dev_groups    = axp20x_groups,
>>       },
>>   };
>>

