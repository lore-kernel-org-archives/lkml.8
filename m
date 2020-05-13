Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF97EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489582065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC6SLGu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbgEMSMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:12:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0352BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:12:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d207so9521773wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FKmP0X074rhYWRT8A/zVAunVrqt1utuHYjckMSL9B7s=;
        b=SC6SLGu9+rvx9jc66c09g6+P4Ytck4Sqguxm8OQ+vJDOyXEITkKYdaybJdQ/VUFhND
         rgUBi1WFKq1l93Tzce8WfLI7WCeRHLjtbup58G0kFvNPnme84m0ySgiT4ZfjR0NIigmd
         w94SS59348B0QbalhAz95j5Ht3flntSgkvc9lcbT3Bp3dnUSvwYXr91tFsQaoMnzXJBX
         MIbK9zCZBFGuWovbTXBkP1CLSAaCja4w0rmnIZ1LPUnnyJmF2Ymz0kg+opVMb2vSKc9w
         nK/U7bJy80JgAceoESBMU/zhqoEIHP5AkUJHvxncxwJjA0rHBQPWLIZ3M0tn7bT+puBA
         /iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FKmP0X074rhYWRT8A/zVAunVrqt1utuHYjckMSL9B7s=;
        b=SuOyG+07AM2ogN8yn8HS+IU66hRdJPVp03U8UtK1UlC9cbb+2qZLrTouHCZwBCHvn/
         XAmmBkym9GNvNfuTf49IvpxIq+3Tf8eSfqE9nymF1z2k+Uq8o2nF14TLp/oGuKZ90wL5
         ia3zaLJ3Qh+p47oI+H/xzmK6HMUbc3c1xNgKPySavQY9EfuQ85CQundDCwDr0dw7P4i9
         FLabYxT0UDZ54ahyrSdXNepn3bIB6miyajecT6EA855GSk9ieHn7GTnfEoS5MzkQeFBL
         D16JMBRgxld/D7FpXTCRVaJNOkt0uEjFDyLtXjG3JXtoBchEnxT7dGdGvUm31WHAUyop
         bxgQ==
X-Gm-Message-State: AGi0PuaXXuEgM5wt/oe7dSPawY8rSS0mhaWv83CjaNmDGoRU9xbRg7sN
        szn4uVUo5BzyWjk29Vin2cg=
X-Google-Smtp-Source: APiQypKjoI+OHtW3SwZVWvLynwGXfk2fjdYS0j/pIC1ZlkELewZjxh1d7Zflnq38AIF4wtw9OoXzuA==
X-Received: by 2002:a1c:df83:: with SMTP id w125mr34609624wmg.140.1589393556694;
        Wed, 13 May 2020 11:12:36 -0700 (PDT)
Received: from wambui.local ([197.237.182.195])
        by smtp.googlemail.com with ESMTPSA id c16sm374839wrv.62.2020.05.13.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:12:35 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Wed, 13 May 2020 21:11:59 +0300 (EAT)
To:     Thomas Zimmermann <tzimmermann@suse.de>
cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] drm/debugfs: create debugfs files during
 drm_dev_register().
In-Reply-To: <47bbbb51-7e53-7c87-6058-5848f9ccecfe@suse.de>
Message-ID: <alpine.LNX.2.21.99999.375.2005132110540.35866@wambui>
References: <20200513114130.28641-1-wambui.karugax@gmail.com> <20200513114130.28641-2-wambui.karugax@gmail.com> <47bbbb51-7e53-7c87-6058-5848f9ccecfe@suse.de>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1044450387-1589393554=:35866"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1044450387-1589393554=:35866
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Wed, 13 May 2020, Thomas Zimmermann wrote:

> Hi
>
> Am 13.05.20 um 13:41 schrieb Wambui Karuga:
>> Introduce the ability to track requests for the addition of drm debugfs
>> files at any time and have them added all at once during
>> drm_dev_register().
>>
>> Drivers can add drm debugfs file requests to a new list tied to drm_device.
>> During drm_dev_register(), the new function drm_debugfs_create_file()
>> will iterate over the list of added files on a given minor to create
>> them.
>>
>> Two new structs are introduced in this change: struct drm_simple_info
>> which represents a drm debugfs file entry and struct
>> drm_simple_info_entry which is used to track file requests and is the
>> main parameter of choice passed by functions. Each drm_simple_info_entry is
>> added to the new struct drm_device->debugfs_list for file requests.
>>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>> ---
>>  drivers/gpu/drm/drm_debugfs.c | 59 ++++++++++++++++++++++++++++++++---
>>  drivers/gpu/drm/drm_drv.c     |  2 ++
>>  include/drm/drm_debugfs.h     | 38 ++++++++++++++++++++++
>>  include/drm/drm_device.h      | 12 +++++++
>>  4 files changed, 107 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
>> index 2bea22130703..03b0588ede68 100644
>> --- a/drivers/gpu/drm/drm_debugfs.c
>> +++ b/drivers/gpu/drm/drm_debugfs.c
>> @@ -145,9 +145,10 @@ static const struct drm_info_list drm_debugfs_list[] = {
>>
>>  static int drm_debugfs_open(struct inode *inode, struct file *file)
>>  {
>> -	struct drm_info_node *node = inode->i_private;
>> +	struct drm_simple_info_entry *entry = inode->i_private;
>> +	struct drm_simple_info *node = &entry->file;
>>
>> -	return single_open(file, node->info_ent->show, node);
>> +	return single_open(file, node->show_fn, entry);
>>  }
>>
>>
>> @@ -159,6 +160,25 @@ static const struct file_operations drm_debugfs_fops = {
>>  	.release = single_release,
>>  };
>>
>> +/**
>> + * drm_debugfs_create_file - create DRM debugfs file.
>> + * @dev: drm_device that the file belongs to
>> + *
>> + * Create a DRM debugfs file from the list of files to be created
>> + * from dev->debugfs_list.
>> + */
>> +static void drm_debugfs_create_file(struct drm_minor *minor)
>
> This function creates several files. I'd rather call it
> drm_debugfs_create_added_files().
>
Okay, that makes sense. I can change that.

>> +{
>> +	struct drm_device *dev = minor->dev;
>> +	struct drm_simple_info_entry *entry;
>> +
>> +	list_for_each_entry(entry, &dev->debugfs_list, list) {
>> +		debugfs_create_file(entry->file.name,
>> +				    S_IFREG | S_IRUGO, minor->debugfs_root,
>> +				    entry,
>> +				    &drm_debugfs_fops);
>> +	}
>
> I think the created items should be removed from the list. That way,
> drivers can call the function multiple times without recreating the same
> files again.
>
Hadn't thought of that - I can try add that.
>> +}
>>
>>  /**
>>   * drm_debugfs_create_files - Initialize a given set of debugfs files for DRM
>> @@ -213,8 +233,7 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>>  	sprintf(name, "%d", minor_id);
>>  	minor->debugfs_root = debugfs_create_dir(name, root);
>>
>> -	drm_debugfs_create_files(drm_debugfs_list, DRM_DEBUGFS_ENTRIES,
>> -				 minor->debugfs_root, minor);
>
> By removing these two lines, aren't you losing the files listed in
> DRM_DEBUGFS_ENTRIES?
>
Yes.
When using the new functions, drm_debugfs_create_files() should not 
be called at this point, but for compatibility these two lines should
be put back, I think.

>> +	drm_debugfs_create_file(minor);
>>
>>  	if (drm_drv_uses_atomic_modeset(dev)) {
>>  		drm_atomic_debugfs_init(minor);
>> @@ -449,4 +468,36 @@ void drm_debugfs_crtc_remove(struct drm_crtc *crtc)
>>  	crtc->debugfs_entry = NULL;
>>  }
>>
>> +void drm_debugfs_add_file(struct drm_device *dev, const char *name,
>> +			  drm_simple_show_t show_fn, void *data)
>> +{
>> +	struct drm_simple_info_entry *entry =
>> +		kzalloc(sizeof(*entry), GFP_KERNEL);
>> +
>> +	if (!entry)
>> +		return;
>> +
>> +	entry->file.name = name;
>> +	entry->file.show_fn = show_fn;
>> +	entry->file.data = data;
>> +	entry->dev = dev;
>> +
>> +	mutex_lock(&dev->debugfs_mutex);
>> +	list_add(&entry->list, &dev->debugfs_list);
>> +	mutex_unlock(&dev->debugfs_mutex);
>> +}
>> +EXPORT_SYMBOL(drm_debugfs_add_file);
>> +
>> +void drm_debugfs_add_files(struct drm_device *dev,
>> +			   const struct drm_simple_info *files, int count)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		drm_debugfs_add_file(dev, files[i].name, files[i].show_fn,
>> +				     files[i].data);
>> +	}
>> +}
>> +EXPORT_SYMBOL(drm_debugfs_add_files);
>> +
>>  #endif /* CONFIG_DEBUG_FS */
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index bc38322f306e..c68df4e31aa0 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -646,12 +646,14 @@ int drm_dev_init(struct drm_device *dev,
>>  	INIT_LIST_HEAD(&dev->filelist_internal);
>>  	INIT_LIST_HEAD(&dev->clientlist);
>>  	INIT_LIST_HEAD(&dev->vblank_event_list);
>> +	INIT_LIST_HEAD(&dev->debugfs_list);
>>
>>  	spin_lock_init(&dev->event_lock);
>>  	mutex_init(&dev->struct_mutex);
>>  	mutex_init(&dev->filelist_mutex);
>>  	mutex_init(&dev->clientlist_mutex);
>>  	mutex_init(&dev->master_mutex);
>> +	mutex_init(&dev->debugfs_mutex);
>>
>>  	ret = drmm_add_action(dev, drm_dev_init_release, NULL);
>>  	if (ret)
>> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
>> index 2188dc83957f..bbce580c3b38 100644
>> --- a/include/drm/drm_debugfs.h
>> +++ b/include/drm/drm_debugfs.h
>> @@ -34,6 +34,44 @@
>>
>>  #include <linux/types.h>
>>  #include <linux/seq_file.h>
>> +
>> +struct drm_device;
>> +
>> +typedef int (*drm_simple_show_t)(struct seq_file *, void *);
>> +
>> +/**
>> + * struct drm_simple_info - debugfs file entry
>> + *
>> + * This struct represents a debugfs file to be created.
>> + */
>> +struct drm_simple_info {
>
> drm_simple_info and drm_simple_info_entry seem to be misnomers. They
> should probably have some reference to debugfs in their name.
>
I'll change the names.

Thanks,
wambui karuga
> Best regards
> Thomas
>
>
>> +	const char *name;
>> +	drm_simple_show_t show_fn;
>> +	u32 driver_features;
>> +	void *data;
>> +};
>> +
>> +/**
>> + * struct drm_simple_info_entry - debugfs list entry
>> + *
>> + * This struct is used in tracking requests for new debugfs files
>> + * to be created.
>> + */
>> +struct drm_simple_info_entry {
>> +	struct drm_device *dev;
>> +	struct drm_simple_info file;
>> +	struct list_head list;
>> +};
>> +
>> +void drm_debugfs_add_file(struct drm_device *dev,
>> +			  const char *name,
>> +			  drm_simple_show_t show_fn,
>> +			  void *data);
>> +
>> +void drm_debugfs_add_files(struct drm_device *dev,
>> +			   const struct drm_simple_info *files,
>> +			   int count);
>> +
>>  /**
>>   * struct drm_info_list - debugfs info list entry
>>   *
>> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
>> index a55874db9dd4..b84dfdac27b7 100644
>> --- a/include/drm/drm_device.h
>> +++ b/include/drm/drm_device.h
>> @@ -326,6 +326,18 @@ struct drm_device {
>>  	 */
>>  	struct drm_fb_helper *fb_helper;
>>
>> +	/**
>> +	 * @debugfs_mutex:
>> +	 * Protects debugfs_list access.
>> +	 */
>> +	struct mutex debugfs_mutex;
>> +
>> +	/** @debugfs_list:
>> +	 * List of debugfs files to add.
>> +	 * Files are added during drm_dev_register().
>> +	 */
>> +	struct list_head debugfs_list;
>> +
>>  	/* Everything below here is for legacy driver, never use! */
>>  	/* private: */
>>  #if IS_ENABLED(CONFIG_DRM_LEGACY)
>>
>
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer
>
>
--8323329-1044450387-1589393554=:35866--
