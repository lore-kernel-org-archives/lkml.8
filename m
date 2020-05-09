Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E7C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E5721775
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgEIExG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:53:06 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:43931 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbgEIExG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:53:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.432172-0.000184779-0.567643;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.HVdq6XF_1588999980;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HVdq6XF_1588999980)
          by smtp.aliyun-inc.com(10.147.41.231);
          Sat, 09 May 2020 12:53:00 +0800
Subject: Re: [PATCH v4 06/12] pstore/blk: Add console frontend support
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200508064004.57898-1-keescook@chromium.org>
 <20200508064004.57898-7-keescook@chromium.org>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <1767506a-cb92-1e06-d41f-e03136857031@allwinnertech.com>
Date:   Sat, 9 May 2020 12:53:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200508064004.57898-7-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/5/8 PM 2:39, Kees Cook wrote:
> From: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> 
> Support backend for console. To enable console backend, just make
> console_size be greater than 0 and a multiple of 4096.
> 
> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> Link: https://lore.kernel.org/r/1585126506-18635-6-git-send-email-liaoweixiong@allwinnertech.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/Kconfig           | 12 +++++++
>  fs/pstore/blk.c             | 12 ++++++-
>  fs/pstore/zone.c            | 67 +++++++++++++++++++++++++++++++++++--
>  include/linux/pstore_zone.h |  4 ++-
>  4 files changed, 90 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index f18cd126d83f..f1484f751c5e 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -236,3 +236,15 @@ config PSTORE_BLK_PMSG_SIZE
>  
>  	  NOTE that, both Kconfig and module parameters can configure
>  	  pstore/blk, but module parameters have priority over Kconfig.
> +
> +config PSTORE_BLK_CONSOLE_SIZE
> +	int "Size in Kbytes of console to store"
> +	depends on PSTORE_BLK
> +	depends on PSTORE_CONSOLE
> +	default 64
> +	help
> +	  This just sets size of console (console_size) for pstore/blk. The
> +	  size is in KB and must be a multiple of 4.
> +
> +	  NOTE that, both Kconfig and module parameters can configure
> +	  pstore/blk, but module parameters have priority over Kconfig.
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index 401e5ba66a5f..813025ea7edd 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -32,6 +32,14 @@ static long pmsg_size = -1;
>  module_param(pmsg_size, long, 0400);
>  MODULE_PARM_DESC(pmsg_size, "pmsg size in kbytes");
>  
> +#if IS_ENABLED(CONFIG_PSTORE_CONSOLE)
> +static long console_size = CONFIG_PSTORE_BLK_CONSOLE_SIZE;
> +#else
> +static long console_size = -1;
> +#endif
> +module_param(console_size, long, 0400);
> +MODULE_PARM_DESC(console_size, "console size in kbytes");
> +
>  /*
>   * blkdev - The block device to use.
>   *
> @@ -83,7 +91,8 @@ static struct bdev_info {
>   *		whole disk).
>   *		On success, the number of bytes should be returned, others
>   *		means error.
> - * @write:	The same as @read.
> + * @write:	The same as @read, but the following error number:
> + *		-EBUSY means try to write again later.
>   * @panic_write:The write operation only used for panic case. It's optional
>   *		if you do not care panic log. The parameters and return value
>   *		are the same as @read.
> @@ -133,6 +142,7 @@ static int psblk_register_do(struct psblk_device *dev)
>  
>  	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
>  	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
> +	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
>  #undef verify_size
>  
>  	pstore_zone_info->total_size = dev->total_size;
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index f472b06a6c14..0b952eea39fe 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -87,10 +87,12 @@ struct pstore_zone {
>   *
>   * @opszs: oops/panic storage zones
>   * @ppsz: pmsg storage zone
> + * @cpsz: console storage zone
>   * @oops_max_cnt: max count of @opszs
>   * @oops_read_cnt: counter to read oops zone
>   * @oops_write_cnt: counter to write
>   * @pmsg_read_cnt: counter to read pmsg zone
> + * @console_read_cnt: counter to read console zone
>   * @oops_counter: counter to oops
>   * @panic_counter: counter to panic
>   * @recovered: whether finish recovering data from storage
> @@ -102,10 +104,12 @@ struct pstore_zone {
>  struct psz_context {
>  	struct pstore_zone **opszs;
>  	struct pstore_zone *ppsz;
> +	struct pstore_zone *cpsz;
>  	unsigned int oops_max_cnt;
>  	unsigned int oops_read_cnt;
>  	unsigned int oops_write_cnt;
>  	unsigned int pmsg_read_cnt;
> +	unsigned int console_read_cnt;
>  	/*
>  	 * the counter should be recovered when recover.
>  	 * It records the oops/panic times after burning rather than booting.
> @@ -125,6 +129,9 @@ struct psz_context {
>  };
>  static struct psz_context psz_cxt;
>  
> +static void psz_flush_all_dirty_zones(struct work_struct *);
> +static DECLARE_WORK(psz_cleaner, psz_flush_all_dirty_zones);

I think it's better to use delayed work.

	static DECLARE_DELAYED_WORK(psz_cleaner, psz_flush_all_dirty_zones);

> +
>  /**
>   * enum psz_flush_mode - flush mode for psz_zone_write()
>   *
> @@ -235,6 +242,9 @@ static int psz_zone_write(struct pstore_zone *zone,
>  	return 0;
>  dirty:
>  	atomic_set(&zone->dirty, true);
> +	/* flush dirty zones nicely */
> +	if (wcnt == -EBUSY && !is_on_panic())
> +		schedule_work(&psz_cleaner);

Change to:
	
	schedule_delayed_work(&psz_cleaner, msecs_to_jiffies(500));

delay for 500ms to merge more log of console and reduce calling times.

>  	return -EBUSY;
>  }
>  
> @@ -291,6 +301,15 @@ static int psz_move_zone(struct pstore_zone *old, struct pstore_zone *new)
>  	return 0;
>  }
>  
> +static void psz_flush_all_dirty_zones(struct work_struct *work)
> +{
> +	struct psz_context *cxt = &psz_cxt;
> +
> +	psz_flush_dirty_zone(cxt->ppsz);
> +	psz_flush_dirty_zone(cxt->cpsz);
> +	psz_flush_dirty_zones(cxt->opszs, cxt->oops_max_cnt);


If flush dirty failed, I think it should try again later.

	int ret = 0;
	
	ret |= psz_flush_dirty_zone(cxt->ppsz);
	ret |= psz_flush_dirty_zone(cxt->cpsz);
	ret |= psz_flush_dirty_zones(cxt->opszs, cxt->oops_max_cnt);
	if (ret)
		schedule_delayed_work(&psz_cleaner, msecs_to_jiffies(1000));

And add this diff:

@@ -714,10 +717,10 @@ static int notrace psz_oops_write(struct
psz_context *cxt,
                return -ENOSPC;

        ret = psz_oops_write_record(cxt, record);
-       if (!ret) {
+       if (!ret && is_on_panic()) {
+               /* ensure all data are flushed to storage when panic */
                pr_debug("try to flush other dirty zones\n");
-               psz_flush_dirty_zones(cxt->opszs, cxt->oops_max_cnt);
-               psz_flush_dirty_zone(cxt->ppsz);
+               psz_flush_all_dirty_zones(NULL);
        }

        /* always return 0 as we had handled it on buffer */

We should flush only when panic since all the dirty zones will be flushed by
delayed_work after this patch.

> +}
> +>  static int psz_recover_oops_data(struct psz_context *cxt)
>  {
>  	struct pstore_zone_info *info = cxt->pstore_zone_info;
> @@ -546,6 +565,10 @@ static inline int psz_recovery(struct psz_context *cxt)
>  	if (ret)
>  		goto recover_fail;
>  
> +	ret = psz_recover_zone(cxt, cxt->cpsz);
> +	if (ret)
> +		goto recover_fail;
> +
>  	pr_debug("recover end!\n");
>  	atomic_set(&cxt->recovered, 1);
>  	return 0;
> @@ -561,6 +584,7 @@ static int psz_pstore_open(struct pstore_info *psi)
>  
>  	cxt->oops_read_cnt = 0;
>  	cxt->pmsg_read_cnt = 0;
> +	cxt->console_read_cnt = 0;
>  	return 0;
>  }
>  
> @@ -625,8 +649,9 @@ static int psz_pstore_erase(struct pstore_record *record)
>  		return psz_oops_erase(cxt, cxt->opszs[record->id], record);
>  	case PSTORE_TYPE_PMSG:
>  		return psz_record_erase(cxt, cxt->ppsz);
> -	default:
> -		return -EINVAL;
> +	case PSTORE_TYPE_CONSOLE:
> +		return psz_record_erase(cxt, cxt->cpsz);
> +	default: return -EINVAL;
>  	}
>  }
>  
> @@ -753,9 +778,18 @@ static int notrace psz_pstore_write(struct pstore_record *record)
>  			record->reason == KMSG_DUMP_PANIC)
>  		atomic_set(&cxt->on_panic, 1);
>  
> +	/*
> +	 * if on panic, do not write except panic records
> +	 * Fix case that panic_write prints log which wakes up console backend.
> +	 */
> +	if (is_on_panic() && record->type != PSTORE_TYPE_DMESG)
> +		return -EBUSY;
> +
>  	switch (record->type) {
>  	case PSTORE_TYPE_DMESG:
>  		return psz_oops_write(cxt, record);
> +	case PSTORE_TYPE_CONSOLE:
> +		return psz_record_write(cxt->cpsz, record);
>  	case PSTORE_TYPE_PMSG:
>  		return psz_record_write(cxt->ppsz, record);
>  	default:
> @@ -780,6 +814,13 @@ static struct pstore_zone *psz_read_next_zone(struct psz_context *cxt)
>  			return zone;
>  	}
>  
> +	if (cxt->console_read_cnt == 0) {
> +		cxt->console_read_cnt++;
> +		zone = cxt->cpsz;
> +		if (psz_old_ok(zone))
> +			return zone;
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -890,6 +931,8 @@ static ssize_t psz_pstore_read(struct pstore_record *record)
>  		readop = psz_oops_read;
>  		record->id = cxt->oops_read_cnt - 1;
>  		break;
> +	case PSTORE_TYPE_CONSOLE:
> +		fallthrough;
>  	case PSTORE_TYPE_PMSG:
>  		readop = psz_record_read;
>  		break;
> @@ -1037,6 +1080,8 @@ static void psz_free_all_zones(struct psz_context *cxt)
>  		psz_free_zones(&cxt->opszs, &cxt->oops_max_cnt);
>  	if (cxt->ppsz)
>  		psz_free_zone(&cxt->ppsz);
> +	if (cxt->cpsz)
> +		psz_free_zone(&cxt->cpsz);
>  }
>  
>  static int psz_alloc_zones(struct psz_context *cxt)
> @@ -1053,6 +1098,14 @@ static int psz_alloc_zones(struct psz_context *cxt)
>  		goto free_out;
>  	}
>  
> +	off_size += info->console_size;
> +	cxt->cpsz = psz_init_zone(PSTORE_TYPE_CONSOLE, &off,
> +			info->console_size);
> +	if (IS_ERR(cxt->cpsz)) {
> +		err = PTR_ERR(cxt->cpsz);
> +		goto free_out;
> +	}
> +
>  	cxt->opszs = psz_init_zones(PSTORE_TYPE_DMESG, &off,
>  			info->total_size - off_size,
>  			info->kmsg_size, &cxt->oops_max_cnt);
> @@ -1086,7 +1139,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
>  		return -EINVAL;
>  	}
>  
> -	if (!info->kmsg_size && !info->pmsg_size) {
> +	if (!info->kmsg_size && !info->pmsg_size && !info->console_size) {
>  		pr_warn("at least one of the records be non-zero\n");
>  		return -EINVAL;
>  	}
> @@ -1114,6 +1167,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
>  	check_size(total_size, 4096);
>  	check_size(kmsg_size, SECTOR_SIZE);
>  	check_size(pmsg_size, SECTOR_SIZE);
> +	check_size(console_size, SECTOR_SIZE);
>  
>  #undef check_size
>  
> @@ -1141,6 +1195,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
>  	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
>  	pr_debug("\toops size : %ld Bytes\n", info->kmsg_size);
>  	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
> +	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
>  
>  	err = psz_alloc_zones(cxt);
>  	if (err) {
> @@ -1173,6 +1228,10 @@ int register_pstore_zone(struct pstore_zone_info *info)
>  		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
>  		pr_cont(" pmsg");
>  	}
> +	if (info->console_size) {
> +		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
> +		pr_cont(" console");
> +	}
>  	pr_cont("\n");
>  
>  	err = pstore_register(&cxt->pstore);
> @@ -1204,6 +1263,8 @@ void unregister_pstore_zone(struct pstore_zone_info *info)
>  {
>  	struct psz_context *cxt = &psz_cxt;
>  
> +	flush_work(&psz_cleaner);
> +


I think it should try to flush dirty zones before unregister in case of
lost data.

	psz_flush_all_dirty_zones(NULL);
	flush_delayed_work(&psz_cleaner);

>  	pstore_unregister(&cxt->pstore);
>  	kfree(cxt->pstore.buf);
>  	cxt->pstore.bufsize = 0;
> diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
> index 39c2cb944123..da294e6d7661 100644
> --- a/include/linux/pstore_zone.h
> +++ b/include/linux/pstore_zone.h
> @@ -18,11 +18,12 @@ typedef ssize_t (*psz_write_op)(const char *, size_t, loff_t);
>   *		it must be multiple of SECTOR_SIZE(512 Bytes).
>   * @max_reason: Maximum kmsg dump reason to store.
>   * @pmsg_size:	The size of pmsg zone which is the same as @kmsg_size.
> + * @console_size:The size of console zone which is the same as @kmsg_size.
>   * @read:	The general read operation. Both of the function parameters
>   *		@size and @offset are relative value to storage.
>   *		On success, the number of bytes should be returned, others
>   *		means error.
> - * @write:	The same as @read.
> + * @write:	The same as @read, but -EBUSY means try to write again later.
>   * @panic_write:The write operation only used for panic case. It's optional
>   *		if you do not care panic log. The parameters and return value
>   *		are the same as @read.
> @@ -35,6 +36,7 @@ struct pstore_zone_info {
>  	unsigned long kmsg_size;
>  	int max_reason;
>  	unsigned long pmsg_size;
> +	unsigned long console_size;
>  	psz_read_op read;
>  	psz_write_op write;
>  	psz_write_op panic_write;
> 

-- 
WeiXiong Liao
