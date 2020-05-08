Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C86C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831DC20746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XhHHaKfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEHGLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgEHGLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:11:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9968AC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:11:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so463969wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7n/EmZfu7QOqdNhnK/vlk0YQydr2bxIIpLlaBagCZw8=;
        b=XhHHaKfdM0jP5tIQGfzoDadhiCClScrnEKnOfG6tQ8z9t1wujAueKu1+BVgFQoR5wf
         BcsGInssQfMIfA59Q5SXcnrDDAJg6gvlu7LpOgNE3ZQo/AZJqH9qKRJBUD32WokrVfMu
         W5BoYLJoG9iL0l7G1TyXFmxm/WqRMApeZp+tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7n/EmZfu7QOqdNhnK/vlk0YQydr2bxIIpLlaBagCZw8=;
        b=GF7cYE+Tp07EF+ZSz/+XXExXNBFkkfmbt28COIombXQITGBKW0p+QLJnXJJ905W56e
         p7wL74fvOPkoLC9tc9q6ssVMgZl7kyGoUYniaAo+5gOHhZUssHkYC4bMO7/qiI7pfI1P
         +TORawbF636Z2FXDPXAnPMJwXwwS6Mhzcy7iBG/tBTuQzpq30BOhIEYIuh+OFX/+BG73
         zuGfUrT8Lg/rMsTWnhCXepOrsZyCKtZ1FwVU0XHkRLDi0OLMNuceyAI+yc/604KF2k6s
         qawfCB2svX7Bu+YepborL4um7WL0rUzDo1P31qiaKaWaMGAw/s+3bJeIgR7ZTuoQkBFc
         TAKQ==
X-Gm-Message-State: AGi0PuagKf8t8tYFQM7YqONLKSJq31NnZYtBYkA6GS7b2McsvJr2PKNl
        QUWnnfd8NPbRhUGg2Cy+Od0l9g==
X-Google-Smtp-Source: APiQypLZXn+BkldHrZN6uLxIGAaFFC1UAR/CZBbHkp9KslHe4y7/vBfOb4EYou2Sr8yCAXrKVTV0JQ==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr930564wrt.163.1588918287981;
        Thu, 07 May 2020 23:11:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s12sm11200835wmc.7.2020.05.07.23.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:11:27 -0700 (PDT)
Date:   Fri, 8 May 2020 08:11:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        rostedt@goodmis.org, mingo@redhat.com, aquini@redhat.com,
        cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508061124.GZ10381@phenom.ffwll.local>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>, jeyu@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, will@kernel.org, mchehab+samsung@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <20200508021438.4373-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508021438.4373-1-mcgrof@kernel.org>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:14:38AM +0000, Luis Chamberlain wrote:
> Device driver firmware can crash, and sometimes, this can leave your
> system in a state which makes the device or subsystem completely
> useless. Detecting this by inspecting /proc/sys/kernel/tainted instead
> of scraping some magical words from the kernel log, which is driver
> specific, is much easier. So instead provide a helper which lets drivers
> annotate this.
> 
> Once this happens, scrapers can easily scrape modules taint flags.
> This will taint both the kernel and respective calling module.
> 
> The new helper module_firmware_crashed() uses LOCKDEP_STILL_OK as
> this fact should in no way shape or form affect lockdep. This taint
> is device driver specific.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Below is the full diff stat of manual inspection throughout the kernel
> when this happens. My methodology is to just scrape for "crash" and
> then study the driver a bit to see if indeed it seems like that the
> firmware crashes there. In *many* cases there is even infrastructure
> for this, so this is sometimes clearly obvious. Some other times it
> required a bit of deciphering.
> 
> The diff stat below is what I have so far, however the patch below
> only includes the drivers that start with Q, as they were a source of
> inspiration for this, and to make this RFC easier to read.
> 
> If this seems sensible, I can follow up with the kernel helper first,
> and then tackle each subsystem independently.
> 
> I purposely skipped review of remoteproc and virtualization. That should
> require its own separate careful review and considerations.
> 
>  drivers/atm/nicstar.c                               |  1 +
>  drivers/bluetooth/hci_qca.c                         |  1 +
>  drivers/gpu/drm/i915/i915_gpu_error.c               |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c         |  2 ++
>  drivers/gpu/drm/msm/msm_gpu.c                       |  1 +

I'm not finding the drm changes in your diff below ... Also what Kees
said, I think best to split this up and properly cc per
get_maintainers.pl.
-Daniel

>  drivers/media/dvb-frontends/sp8870.c                |  1 +
>  drivers/media/pci/ttpci/av7110.c                    |  1 +
>  drivers/misc/mic/cosm/cosm_scif_server.c            |  1 +
>  drivers/net/ethernet/8390/axnet_cs.c                |  4 +++-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c    |  1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c   |  1 +
>  drivers/net/ethernet/brocade/bna/bfa_ioc.c          |  1 +
>  drivers/net/ethernet/cavium/liquidio/lio_main.c     |  1 +
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c     |  1 +
>  drivers/net/ethernet/ibm/ehea/ehea_main.c           |  2 ++
>  drivers/net/ethernet/qlogic/qed/qed_debug.c         |  3 +++
>  drivers/net/ipa/ipa_modem.c                         |  1 +
>  drivers/net/wimax/i2400m/rx.c                       |  1 +
>  drivers/net/wireless/ath/ath10k/pci.c               |  2 ++
>  drivers/net/wireless/ath/ath10k/sdio.c              |  2 ++
>  drivers/net/wireless/ath/ath10k/snoc.c              |  1 +
>  drivers/net/wireless/ath/ath6kl/hif.c               |  1 +
>  .../net/wireless/broadcom/brcm80211/brcmfmac/core.c |  1 +
>  drivers/net/wireless/marvell/mwl8k.c                |  1 +
>  drivers/scsi/bfa/bfa_ioc.c                          |  1 +
>  drivers/scsi/megaraid/megaraid_sas_fusion.c         |  1 +
>  drivers/scsi/qla4xxx/ql4_mbx.c                      |  2 ++
>  drivers/staging/media/omap4iss/iss.c                |  1 +
>  include/linux/kernel.h                              |  3 ++-
>  include/linux/module.h                              | 13 +++++++++++++
>  include/trace/events/module.h                       |  3 ++-
>  kernel/module.c                                     |  5 +++--
>  kernel/panic.c                                      |  1 +
>  33 files changed, 58 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> index f4eebaabb6d0..9cc6287b889b 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
> @@ -7854,6 +7854,7 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
>  						 REGDUMP_HEADER_SIZE,
>  						 &feature_size);
>  		if (!rc) {
> +			module_firmware_crashed();
>  			*(u32 *)((u8 *)buffer + offset) =
>  			    qed_calc_regdump_header(cdev, PROTECTION_OVERRIDE,
>  						    cur_engine,
> @@ -7869,6 +7870,7 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
>  		rc = qed_dbg_fw_asserts(cdev, (u8 *)buffer + offset +
>  					REGDUMP_HEADER_SIZE, &feature_size);
>  		if (!rc) {
> +			module_firmware_crashed();
>  			*(u32 *)((u8 *)buffer + offset) =
>  			    qed_calc_regdump_header(cdev, FW_ASSERTS,
>  						    cur_engine, feature_size,
> @@ -7906,6 +7908,7 @@ int qed_dbg_all_data(struct qed_dev *cdev, void *buffer)
>  		rc = qed_dbg_grc(cdev, (u8 *)buffer + offset +
>  				 REGDUMP_HEADER_SIZE, &feature_size);
>  		if (!rc) {
> +			module_firmware_crashed();
>  			*(u32 *)((u8 *)buffer + offset) =
>  			    qed_calc_regdump_header(cdev, GRC_DUMP,
>  						    cur_engine,
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> index 1d941d53fdc9..6bd0f3b518b9 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -1767,6 +1767,7 @@ static void ath10k_pci_fw_dump_work(struct work_struct *work)
>  		scnprintf(guid, sizeof(guid), "n/a");
>  
>  	ath10k_err(ar, "firmware crashed! (guid %s)\n", guid);
> +	module_firmware_crashed();
>  	ath10k_print_driver_info(ar);
>  	ath10k_pci_dump_registers(ar, crash_data);
>  	ath10k_ce_dump_registers(ar, crash_data);
> @@ -2837,6 +2838,7 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
>  	if (ret) {
>  		if (ath10k_pci_has_fw_crashed(ar)) {
>  			ath10k_warn(ar, "firmware crashed during chip reset\n");
> +			module_firmware_crashed();
>  			ath10k_pci_fw_crashed_clear(ar);
>  			ath10k_pci_fw_crashed_dump(ar);
>  		}
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index e2aff2254a40..d34ad289380f 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -794,6 +794,7 @@ static int ath10k_sdio_mbox_proc_dbg_intr(struct ath10k *ar)
>  
>  	/* TODO: Add firmware crash handling */
>  	ath10k_warn(ar, "firmware crashed\n");
> +	module_firmware_crashed();
>  
>  	/* read counter to clear the interrupt, the debug error interrupt is
>  	 * counter 0.
> @@ -915,6 +916,7 @@ static int ath10k_sdio_mbox_proc_cpu_intr(struct ath10k *ar)
>  	if (cpu_int_status & MBOX_CPU_STATUS_ENABLE_ASSERT_MASK) {
>  		ath10k_err(ar, "firmware crashed!\n");
>  		queue_work(ar->workqueue, &ar->restart_work);
> +		module_firmware_crashed();
>  	}
>  	return ret;
>  }
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 354d49b1cd45..7cfc123c345c 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1451,6 +1451,7 @@ void ath10k_snoc_fw_crashed_dump(struct ath10k *ar)
>  		scnprintf(guid, sizeof(guid), "n/a");
>  
>  	ath10k_err(ar, "firmware crashed! (guid %s)\n", guid);
> +	module_firmware_crashed();
>  	ath10k_print_driver_info(ar);
>  	ath10k_msa_dump_memory(ar, crash_data);
>  	mutex_unlock(&ar->dump_mutex);
> diff --git a/drivers/net/wireless/ath/ath6kl/hif.c b/drivers/net/wireless/ath/ath6kl/hif.c
> index d1942537ea10..cfd838607544 100644
> --- a/drivers/net/wireless/ath/ath6kl/hif.c
> +++ b/drivers/net/wireless/ath/ath6kl/hif.c
> @@ -120,6 +120,7 @@ static int ath6kl_hif_proc_dbg_intr(struct ath6kl_device *dev)
>  	int ret;
>  
>  	ath6kl_warn("firmware crashed\n");
> +	module_firmware_crashed();
>  
>  	/*
>  	 * read counter to clear the interrupt, the debug error interrupt is
> diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
> index 02636b4785c5..39a58ba5df0a 100644
> --- a/drivers/scsi/qla4xxx/ql4_mbx.c
> +++ b/drivers/scsi/qla4xxx/ql4_mbx.c
> @@ -1016,6 +1016,8 @@ void qla4xxx_get_crash_record(struct scsi_qla_host * ha)
>  	dma_addr_t crash_record_dma = 0;
>  	uint32_t crash_record_size = 0;
>  
> +	module_firmware_crashed();
> +
>  	memset(&mbox_cmd, 0, sizeof(mbox_cmd));
>  	memset(&mbox_sts, 0, sizeof(mbox_cmd));
>  
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 04a5885cec1b..19e1541c82c7 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -601,7 +601,8 @@ extern enum system_states {
>  #define TAINT_LIVEPATCH			15
>  #define TAINT_AUX			16
>  #define TAINT_RANDSTRUCT		17
> -#define TAINT_FLAGS_COUNT		18
> +#define TAINT_FIRMWARE_CRASH		18
> +#define TAINT_FLAGS_COUNT		19
>  
>  struct taint_flag {
>  	char c_true;	/* character printed when tainted */
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 1ad393e62bef..de9156dfe6bb 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -697,6 +697,14 @@ static inline bool is_livepatch_module(struct module *mod)
>  bool is_module_sig_enforced(void);
>  void set_module_sig_enforced(void);
>  
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok);
> +
> +static inline void module_firmware_crashed(void)
> +{
> +	add_taint_module(THIS_MODULE, TAINT_FIRMWARE_CRASH, LOCKDEP_STILL_OK);
> +}
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -844,6 +852,11 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>  	return ptr;
>  }
>  
> +static inline void module_firmware_crashed(void)
> +{
> +	add_taint(TAINT_FIRMWARE_CRASH, val);
> +}
> +
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/include/trace/events/module.h b/include/trace/events/module.h
> index 097485c73c01..b749ea25affd 100644
> --- a/include/trace/events/module.h
> +++ b/include/trace/events/module.h
> @@ -26,7 +26,8 @@ struct module;
>  	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
>  	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
>  	{ (1UL << TAINT_CRAP),			"C" },		\
> -	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
> +	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> +	{ (1UL << TAINT_FIRMWARE_CRASH),	"Q" })
>  
>  TRACE_EVENT(module_load,
>  
> diff --git a/kernel/module.c b/kernel/module.c
> index d626dc31b37f..06e6e645dbd4 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -325,12 +325,13 @@ static inline int strong_try_module_get(struct module *mod)
>  		return -ENOENT;
>  }
>  
> -static inline void add_taint_module(struct module *mod, unsigned flag,
> -				    enum lockdep_ok lockdep_ok)
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok)
>  {
>  	add_taint(flag, lockdep_ok);
>  	set_bit(flag, &mod->taints);
>  }
> +EXPORT_SYMBOL_GPL(add_taint_module);
>  
>  /*
>   * A thread that wants to hold a reference to a module only while it
> diff --git a/kernel/panic.c b/kernel/panic.c
> index ec6d7d788ce7..504fb926947e 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -384,6 +384,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
>  	[ TAINT_AUX ]			= { 'X', ' ', true },
>  	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
> +	[ TAINT_FIRMWARE_CRASH ]	= { 'Q', ' ', true },
>  };
>  
>  /**
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
