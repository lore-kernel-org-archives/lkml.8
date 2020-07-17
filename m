Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EC020717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFvShSzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGQNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:32:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbgGQNcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594992751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gw7Bdg5F6PTJRpZOqnV/ZVS3jnjuaxd2N0oczZTUZYw=;
        b=hFvShSzP3+GF25ieuiTCnNWYr9LT7HOCI4+FfBk74dZDJX5D/0bBPddM6asy5foMXrteCT
        /JYuWqYwXONEv/4F5YQdv8SXeyWEnPLdojCF73SkjAV6Nfgz20NutZ/RXrV0MrqCgp6vMo
        lErxlP+MTkujGUJSXVvOPMIUWjj1E8Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-7lYyssRSNbO7LNHT5ank8A-1; Fri, 17 Jul 2020 09:32:30 -0400
X-MC-Unique: 7lYyssRSNbO7LNHT5ank8A-1
Received: by mail-qv1-f70.google.com with SMTP id l12so5499220qvu.21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gw7Bdg5F6PTJRpZOqnV/ZVS3jnjuaxd2N0oczZTUZYw=;
        b=X5jttXYHfvpzNTB/z17LjCwzsXVTXNRE9xB5EOrncQvOMU9PN8WQXz4Tz/WL1UsFBy
         hkIWu93XmSkEBY3DwBy219C8hrsKK1vA71njTKFx/wlll7j9L6Nbc4p48OYVWkDfIVgF
         zOFNr1sWn+/gJxC69DG6mP4Bp44+9DHy7WJnMare+QvN6Wm4Ap60Iil33A8PNcMo8J+E
         F2usLa4K+GkgbiCzyWunJTZcZMtqPjD94iMefaED23ekR3y5KOW0f+4eJuMeWKtnbMFA
         h+Rjmzn0muEf6o2vW+AW4yOxEN6iVNi7pxZIp9UkUMZo+CsJJlLw3LVb1TPMUUbtB7uq
         cgwA==
X-Gm-Message-State: AOAM533rJ+ZwnJLgemJa+F/I2TV7ZqTsCXWuPnrggP7YumPB/fc/AjOT
        YujMc48EJqC3v5NVynL0WJFP4aXzejhlbR9oaaGlxtMSNyqloJoXD4skMoQBBQisg7Rd0SCRi7G
        RBJOkuZbZxrh9yRILNZA7CbPi
X-Received: by 2002:ac8:1305:: with SMTP id e5mr10471764qtj.78.1594992749435;
        Fri, 17 Jul 2020 06:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVukT5N1A8RHevyQUfkREmmAlrpMLsNUwqg40Hvp+6mZmIfyRmX1j7yE1q3Z+1fCBkwQPYqw==
X-Received: by 2002:ac8:1305:: with SMTP id e5mr10471725qtj.78.1594992749028;
        Fri, 17 Jul 2020 06:32:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j24sm9568765qkl.79.2020.07.17.06.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 06:32:28 -0700 (PDT)
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
 <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <237c776b-8746-421d-26ad-eea7242a9172@redhat.com>
Date:   Fri, 17 Jul 2020 06:32:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/20 8:48 PM, Wu, Hao wrote:
>> Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
>>
>> Generally i think this is a good approach.
>>
>> However I do have concern.
>>
>> The feature_id in dfl is magic number, similar to pci id but without a vendor
>> id.
>>
>> Is it possible to add something like a vendor id so different vendors would
>> not have to be so careful to use a unique id ?
> Hi Tom,
>
> Thanks for the comments.
>
> Here is only one field defined in spec, that is feature id to distinguish one
> feature with another one. There is no vendor id here I think, and several
> cards are using this for now and seems not possible to change DFH format
> for these products. : (

There looks like some unused bits in the first word, how about

#define DFH_EOL            BIT_ULL(40)        /* End of list */

+define DFH_VENDOR    GENMAKE_ULL(49,41) /* Vendor ID */

#define DFH_TYPE        GENMASK_ULL(63, 60)    /* Feature type */

And Intel gets id 0.

>
> I fully understand the concern is the feature id management, and potential
> conflicts there from different vendors. One possible method to resolve this
> is managing the ids in a public place (web? Or just the driver header file for
> feature id definition), all vendors can request some feature ids, and other
> people can see which feature ids have been used so that they can avoid
> using conflict ones with other people.

The conflict will come in development when two vendors use the same unpublished feature id.

Also keeping the truth of id's in the kernel source isn't that great because the public kernel always lags development repositories.

>
> And in the later version DFH, this feature id will be replaced with GUID
> I think, so it can resolve the conflict problems from different vendors?
> But now, we still need to handle the existing ones. : )

This is why I proposed needing to generalize the matching.

>
> Thanks
> Hao
>
>> This touches some of the matching function of the bus ops.  Could there be a
>> way for bus ops to be used so that there could be multiple matching
>> function.  Maybe the one in 0002 as a default so users could override it ?
>>
>> The use case I am worrying about is an OEM.  The OEM uses an unclaimed
>> feature_id and supplies their own platform device device driver to match the
>> feature_id.  But some later version of the kernel claims this feature_id and
>> the OEM's driver no longer works and since the value comes from pci config
>> space it is difficult to change.
>>
>> So looking for something like
>>
>> register_feature_matcher((*bus_match)(struct device *dev, struct
>> device_driver *drv))
>>
>> static int dfl_bus_match_default(struct device *dev, struct device_driver *drv)
>> {
>>     struct dfl_device *dfl_dev = to_dfl_dev(dev);
>>     struct dfl_driver *dfl_drv = to_dfl_drv(drv);
>>     const struct dfl_device_id *id_entry = dfl_drv->id_table;
>>
>>     while (id_entry->feature_id) {
>>         if (dfl_match_one_device(id_entry, dfl_dev)) {
>>             dfl_dev->id_entry = id_entry;
>>             return 1;
>>         }
>>         id_entry++;
>>     }
>>
>>     return 0;
>> }
>>
>> register_feature_matcher(&dfl_bus_match_default)
>>
>> static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>> {
>>
>>     struct dfl_device *dfl_dev = to_dfl_dev(dev);
>>     struct dfl_driver *dfl_drv = to_dfl_drv(drv);
>>     const struct dfl_device_id *id_entry = dfl_drv->id_table;
>>
>>     while (id_entry->feature_id) {
>>
>>         matcher = Loop over matchers()
>>
>>         if (matcher(dev, drv)) {
>>             dfl_dev->id_entry = id_entry;
>>             return 1;
>>         }
>>         id_entry++;
>>     }
>>
>>     return 0;
>> }
>>
>> Or maybe use some of the unused bits in the dfl header to add a second
>> vendor-like id and change existing matcher to look feature_id and
>> vendor_like_id.
>>
>> Tom
>>
>>
>>
>> On 7/14/20 10:38 PM, Xu Yilun wrote:
>>> This patchset makes it possible to develop independent driver modules
>>> for DFL private features. It also helps to leverage existing kernel
>>> drivers to enable some IP blocks in DFL.
>>>
>>> Xu Yilun (2):
>>>   fpga: dfl: map feature mmio resources in their own feature drivers
>>>   fpga: dfl: create a dfl bus type to support DFL devices
>>>
>>>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>>>  drivers/fpga/dfl-pci.c                  |  21 +-
>>>  drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
>>>  drivers/fpga/dfl.h                      |  91 ++++++-
>>>  4 files changed, 492 insertions(+), 70 deletions(-)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>>>

