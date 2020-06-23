Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA37C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2159F20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GClWvKIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbgFWRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733160AbgFWRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:55:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D42C061573;
        Tue, 23 Jun 2020 10:55:53 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x62so12724758qtd.3;
        Tue, 23 Jun 2020 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZIdvkMdtxmRbis1RgDN+t39+YYrGlL+Xtqf4O1eNdfQ=;
        b=GClWvKIg/ZraeiAIF2Zy6BZssPsT5L1apkY72CmjLqICdt1oqzj2qOZrgIxZtQ8X3a
         GOeGme4D7+mElM+esF7o2VeXMC0nn/idnHAVaOHn7wyQySFPrNrCB2M/6qZcsII1SZfH
         4QXmHIcPzbLmugcIHbeCf6I/GyXPSptfp/xv0r9z1SFURv2mku9m06vOPxg2dsJUzRZ5
         WuhtCd2UpgbwSFB+4gwpyckXLvVJQf3OHx8UEK1V9jJb0YWDWhCu3GUYwLb+CA9KokgO
         jxuszyx02mw9GsX9iJ+g+ohO35gl24eq3ZQggdKHG5m/yEF4f6h1d9/XGke0sWERsEPa
         whFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIdvkMdtxmRbis1RgDN+t39+YYrGlL+Xtqf4O1eNdfQ=;
        b=U1nxMUoUYvR7tg5pyQGzIGD0ZUBEltE5VNVNW+AFTyyA8oE3uyJP4UkLN1LqR/z7C9
         mRlBYDOeHyGJS5B2eq8RiljKMOEZ5Lm1c5qaeBHoGG9F7/sX7hJ5Lti7gsSQxE5j6v3J
         WJh3qtyi3+15nWG9XKw1zVwQ4fKcpaiG7xvrI5zkiXUeoZIitcUW6EO08qHjdkmhkz4G
         KM04bwdUXhrJPm2ZprPUIy1rX4HtOm/8E950qblaBy/goAqvlQs0zNj0J0SDrU1e4ZzJ
         fUHDWcRf7EaIErXah1lSFYBM/kuGw0Dm/6T3m9gs3HCLkPnhlA2MMP07Cp/VppL0d4WA
         vvJQ==
X-Gm-Message-State: AOAM533m7sfud7sM56Eo+r6OJjCYQTRy5+87D8lweS7lEUSlpXjI+pd3
        rMbWFYziUVKnq1b+UjN4cI5qUmnXHdA=
X-Google-Smtp-Source: ABdhPJxE2LmKubLnuS/3/ohyUkolSWLNIzZeNO6Iq1lPJTmIScqokyhEuc+muFZwwzqVUJN73A1xJw==
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr11162056qtu.206.1592934952518;
        Tue, 23 Jun 2020 10:55:52 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id l56sm1402939qtl.33.2020.06.23.10.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 10:55:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
 <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
 <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
 <20200623064723.GZ954398@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
Date:   Tue, 23 Jun 2020 12:55:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623064723.GZ954398@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-23 01:47, Lee Jones wrote:
> On Mon, 22 Jun 2020, Frank Rowand wrote:
> 
>> On 2020-06-22 14:11, Lee Jones wrote:
>>> On Mon, 22 Jun 2020, Frank Rowand wrote:
>>>
>>>> On 2020-06-22 10:10, Lee Jones wrote:
>>>>> On Mon, 22 Jun 2020, Frank Rowand wrote:
>>>>>
>>>>>> On 2020-06-22 03:50, Lee Jones wrote:
>>>>>>> On Thu, 18 Jun 2020, Frank Rowand wrote:
>>>>>>>
>>>>>>>> On 2020-06-15 04:26, Lee Jones wrote:
>>>>>>>>> On Sun, 14 Jun 2020, Frank Rowand wrote:
>>>>>>>>>
>>>>>>>>>> Hi Lee,
>>>>>>>>>>
>>>>>>>>>> I'm looking at 5.8-rc1.
>>>>>>>>>>
>>>>>>>>>> The only use of OF_MFD_CELL() where the same compatible is specified
>>>>>>>>>> for multiple elements of a struct mfd_cell array is for compatible
>>>>>>>>>> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
>>>>>>>>>>
>>>>>>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>>>>>>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
>>>>>>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>>>>>>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
>>>>>>>>>>         OF_MFD_CELL("ab8500-pwm",
>>>>>>>>>>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
>>>>>>>>
>>>>>>>>          OF_MFD_CELL("ab8500-pwm",
>>>>>>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>>>>>>>
>>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
>>>>>>>>>> are:
>>>>>>>>>>
>>>>>>>>>>    arch/arm/boot/dts/ste-ab8500.dtsi
>>>>>>>>>>    arch/arm/boot/dts/ste-ab8505.dtsi
>>>>>>>>>>
>>>>>>>>>> These two .dtsi files only have a single node with this compatible.
>>>>>>>>>> Chasing back to .dts and .dtsi files that include these two .dtsi
>>>>>>>>>> files, I see no case where there are multiple nodes with this
>>>>>>>>>> compatible.
>>>>>>>>>>
>>>>>>>>>> So it looks to me like there is no .dts in mainline that is providing
>>>>>>>>>> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
>>>>>>>>>> is expecting.  No case that there are multiple mfd child nodes where
>>>>>>>>>> mfd_add_device() would assign the first of n child nodes with the
>>>>>>>>>> same compatible to multiple devices.
>>>>>>>>>>
>>>>>>>>>> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
>>>>>>>>>> Am I missing something here?
>>>>>>>>>>
>>>>>>>>>> If I am correct, then either drivers/mfd/ab8500-core.c or
>>>>>>>>>> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
>>>>>>>>>
>>>>>>>>> Your analysis is correct.
>>>>>>>>
>>>>>>>> OK, if I'm not overlooking anything, that is good news.
>>>>>>>>
>>>>>>>> Existing .dts source files only have one "ab8500-pwm" child.  They already
>>>>>>>> work correcly.
>>>>>>>>
>>>>>>>> Create a new compatible for the case of multiple children.  In my example
>>>>>>>> I will add "-mc" (multiple children) to the existing compatible.  There
>>>>>>>> is likely a better name, but this lets me provide an example.
>>>>>>>>
>>>>>>>> Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
>>>>>>>> source files with multiple children use the new compatible:
>>>>>>>>
>>>>>>>>          OF_MFD_CELL("ab8500-pwm",
>>>>>>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
>>>>>>>>
>>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>>>>>>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>>>>>>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
>>>>>>>>
>>>>>>>> The "OF_MFD_CELL" entry is the existing entry, which will handle current
>>>>>>>> .dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
>>>>>>>> .dts source files.
>>>>>>>
>>>>>>> Sorry, but I'm not sure what the above exercise is supposed to solve.
>>>>>>>
>>>>>>> Could you explain it for me please?
>>>>>>
>>>>>> The OF_MFD_CELL() entry handles all of the existing .dts source files
>>>>>> that only have one ab8500-pwm child nodes.  So existing .dtb blobs
>>>>>> continue to work.
>>>>>>
>>>>>> The OF_MFD_CELL_REG() entries will handle all of the new .dts source
>>>>>> files that will have up to 3 ab8500-pwm child nodes.
>>>>>>
>>>>>> Compatibility is maintained for existing .dtb files.  A new kernel
>>>>>> version with the changes will support new .dtb files that contain
>>>>>> multiple ab8500-pwm child nodes.
>>>>>
>>>>> I can see *what* you're trying to do.  I was looking for an
>>>>> explanation of *how* you think that will work.  FWIW, I don't think
>>>>> what you're proposing will work as you envisage.  I thought that
>>>>> perhaps I was missing something, which is why I requested further
>>>>> explanation.
>>>>>
>>>>>>>> And of course the patch that creates OF_MFD_CELL_REG() needs to precede
>>>>>>>> this change.
>>>>>>>>
>>>>>>>> I would remove the fallback code in the existing patch that tries to
>>>>>>>> handle an incorrect binding.  Just error out if the binding is not
>>>>>>>> used properly.
>>>>>>>
>>>>>>> What fallback code?
>>>>>>
>>>>>> Based on reading the patch description, I expected some extra code to try
>>>>>> to handle the case where the compatible in more than one struct mfd_cell
>>>>>> entry is "stericsson,ab8500-pwm" and there are multiple ab8500-pwm child
>>>>>> nodes.
>>>>>>
>>>>>> Looking at the actual code (which I had not done before), I see that the
>>>>>> "best effort attempt to match" is keeping a list of child nodes that
>>>>>> have already been used (mfd_of_node_list) and avoiding re-use of such
>>>>>> nodes.  This allows an invalid .dtb (one with multple "stericsson,ab8500-pwm"
>>>>>> child nodes) to possibly be assigned unique child nodes for multiple
>>>>>> struct mfd_cell entries to be "stericsson,ab8500-pwm".
>>>>>>
>>>>>> So it is confusing for me to call that "fallback code".  It really is
>>>>>> "best effort attempt to match" for a broken .dtb code.
>>>>>>
>>>>>> There should be no best effort for a broken .dtb.  The broken .dtb should
>>>>>> instead result in an error.
>>>>>
>>>>> The problem is, how can you tell the difference between a valid and a
>>>>> broken FDT without pre-processing - which, as I explained in the
>>>>> commit message, I am not prepared to do.  We cannot test individually
>>>>> since all configurations (e.g. no 'reg' property are valid on an
>>>>> individual basis.
>>>>
>>>> If my proposed changes are made, then there are at least 3 ways to detect
>>>> a broken FDT or prevent the problem caused by the broken FDT.
>>>>
>>>>
>>>> 1) Use the validation process that uses the bindings to validate the
>>>> devicetree source.
>>>
>>> Could you provide an example please?
>>
>> I'm sorry I don't have a concise description and example.  I have not been
>> keeping up with the state of the art in this area.
>>
>> A terribly non-precise pointer to the general area is:
>>
>>   https://elinux.org/Device_tree_future#Devicetree_Verification
>>
>> As a general comment, I think that validation / verification is a very
>> valuable tool, but the schemas to support it are an ongoing project.
>>
>> Even after the schemas are all in place, it will still be possible for
>> bad FDTs to be fed to the kernel, so it is not a total pancea.
> 
> Ah, you meant schema.  Yes, I know what that is, I just didn't
> connect the two from the description above.
> 
>>>> 2) Modify patch 1/3.  The small part of the patch to modify is:
>>>>
>>>> +static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>>>> +				    struct device_node *np,
>>>> +				    const struct mfd_cell *cell)
>>>> +{
>>>> +	struct mfd_of_node_entry *of_entry;
>>>> +	const __be32 *reg;
>>>> +	u64 of_node_addr;
>>>> +
>>>> +	/* Skip devices 'disabled' by Device Tree */
>>>> +	if (!of_device_is_available(np))
>>>> +		return -ENODEV;
>>>> +
>>>> +	/* Skip if OF node has previously been allocated to a device */
>>>> +	list_for_each_entry(of_entry, &mfd_of_node_list, list)
>>>>
>>>> Change:
>>>>
>>>> +		if (of_entry->np == np)
>>>> +			return -EAGAIN;
>>>>
>>>> To:
>>>>
>>>> +		if (of_entry->np == np) {
>>>> +			if (!cell->use_of_reg)
>>>> +				return -EINVAL;
>>>> +			else
>>>> +				return -EAGAIN;
>>>>
>>>> There may be a better choice than EINVAL, but I am just showing the method.
>>>>
>>>> You may also want to refactor this section of the patch slightly
>>>> differently to achieve the same result.  It was just easiest to
>>>> show the suggested change the way I did it.
>>>>
>>>> The test that returns EINVAL detects the issue that the FDT does
>>>> not match the binding (there is more one child node with the
>>>> "stericsson,ab8500-pwm" compatible.
>>>
>>> So here, instead of just failing a single device, we fail everything?
>>> Sounds a lot like throwing the baby out with the bath water.  How is
>>> that an improvement?
> 
> [0]

Is "[0]" the patch series, especially patch 1/3?

> 
>>>> 3) I'm not sure if the pre-parsing that is wanted is parsing of the
>>>> devicetree or parsing of the struct mfd_cell array.  If the mfd_cell
>>>> array then solution 3 is not acceptable.
>>>>
>>>> A different change to a small part of patch 1/3.  In mfd_add_devices(),
>>>> validate parameter "cells".  The validation could precede the existing
>>>> code, or it could be folded into the existing for loop.  The validation
>>>> is checking for any other element of the cells array containing
>>>> the same compatible value if cell->use_of_reg is not true for an element.
>>>>
>>>> If this validation occurs, then I think mfd_of_node_list, and all the
>>>> associated code to deal with it is no longer needed.  But I didn't
>>>> look at this part in detail, so maybe I missed something.
>>>>
>>>> The validation is something like (untested):
>>>>
>>>> 	if (IS_ENABLED(CONFIG_OF)
>>>> 		for (i = 0; i < n_devs; i++) {
>>>> 			this_cell = cells + i;
>>>> 			if (!this_cell->use_of_reg) {
>>>> 				for (j = 1; j < n_devs; j++) {
>>>> 					if (j != i) {
>>>> 						cell = cells + j;
>>>> 						if (!strcmp(this_cell->of_compatible, cell->of_compatible))
>>>> 							return -EINVAL;
>>>> 					}
>>>> 				}
>>>> 			}
>>>> 		}
>>>
>>> I think I just threw-up a little. ;)
>>
>> I'm not surprised.
>>
>> But it actually is pretty simple code.
>>
>>>
>>> Did you read the commit message?
>>
>> Yes, I did.
>>
>>>
>>>   "We could code around this with some pre-parsing semantics, but the
>>
>> And as I said above, it was not clear to me what was meant by pre-parsing.
>>
>>>   added complexity required to cover each and every corner-case is not
>>>   justified.  Merely patching the current failing (via this patch) is
>>>   already working with some pretty small corner-cases"
>>>   
>>> Providing thorough pre-parsing would be highly complex and highly
>>> error prone.  The example you provide above is not only ugly, there
>>> are numerous issues with it.  Not least:
>>>
>>>  * Only one corner-case is covered
>>
>> I agree with this.  I also agree it is a fool's errand to try to add
>> code to fully validate all possible devicetree source errors in
>> driver source.
> 
> Great.  Phew!
> 
>>>  * Validation is only completed on a single mfd_cells struct
>>
>> On a single _array_ of struct mfd_cells.  But this does appear
>> to be a fatal flaw.  I had not looked at enough callers of
>> mfd_add_devices() to see that it is a common pattern for
>> a single driver to call it multiple times.
> 
> Exactly.
> 
>>>  * False positives can occur and will fail as a result
>>
>> ((What is an example of a false positive?))  Never mind, now that
>> I see that the previous issue is a fatal flaw, this becomes
>> academic.
> 
> That's okay, I don't mind discussing.
> 
> Ironically, the 'ab8500-pwm' is a good example of a false positive,
> since it's fine for the DT nodes to be identical.  So long as there
> are nodes present for each instance, it doesn't matter which one is
> allocated to which device .Forcing a 'reg' property onto them for no> good reason it not a valid solution here.

I thought that one of the points of this patch series was to add a
"reg" property to any mfd child that was described by the
OF_MFD_CELL_REG() macro.

And that was meant to fix the problem where multiple indistinguishable
children existed.  The only instance I found of that (using the
weak search on OF_MFD_CELL()) was of compatible "stericsson,ab8500-pwm"
in drivers/mfd/ab8500-core.c.  You agreed with my email that
reported that.

So I thought that drivers/mfd/ab8500-core.c would be modified to
replace the multiple instances of compatible "stericsson,ab8500-pwm"
in OF_MFD_CELL() with OF_MFD_CELL_REG().

This is another problem with the patch series: there is no user
of OF_MFD_CELL_REG().  Please add one to the series.

> 
>>> The above actually makes the solution worse, not better.
>>>
>>
>> Patch 1/3 silently fails to deal with a broken devicetree.
>> It results on one of the three ab8500-pwm child nodes in
>> the hypothetical devicetree source tree not being added.
>>
>> That is not a good result either.
> 
> No it doesn't.  In the case of 'ab8500-pwm' the OF node is not set for
> 2 of the devices and warnings are presented in the kernel log.

OK, I was wrong about "silent".  There is a warning:
   pr_warn("%s: Failed to locate of_node [id: %d]\n",

> The
> device will continue to probe and function as usual.

If the device probes and functions as usual without the child of_node,
then why does the node have any properties (for the cases of
arch/arm/boot/dts/ste-ab8500.dtsi and arch/arm/boot/dts/ste-ab8505.dtsi
the properties "clocks" and "clock-names").

Digging through that leads to yet another related question, or actually
sort of the same question.  Why do the child nodes with compatible
"stericsson,ab8500-pwm" have the properties "clocks" and "clock-names"
since the binding Documentation/devicetree/bindings/mfd/ab8500.txt
does not list them?

> 
>> OK, so my solution #3 is a no go.  How about my solution #2,
>> which you did not comment on?
> 
> I did [0].  You must have missed it. :)

But yes or no to my solution #2 (with some slight changes to
make it better (more gracious handling of the detected error) as
discussed elsewhere in the email thread)?

> 
> It also suffers with false positives.
> 

