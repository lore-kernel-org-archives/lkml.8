Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:52289 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727648AbgCKD0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:26:53 -0400
Date: Wed, 11 Mar 2020 12:18:54 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "moderated list:FIREWIRE AUDIO DRIVERS and IEC 61883-1/6 PACKET..."
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 8/8] ALSA: firewire-tascam: Add missing annotation for
 tscm_hwdep_read_locked()
Message-ID: <20200311031853.GA8197@workstation>
References: <0/8>
 <20200311010908.42366-1-jbi.octave@gmail.com>
 <20200311010908.42366-9-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311010908.42366-9-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311031854.J07bz5swEiKyfuwzMnQ0Un-shn-1rbW9H06CZRJtA-g@z>

Hi,

On Wed, Mar 11, 2020 at 01:09:08AM +0000, Jules Irenge wrote:
> Sparse reports a warning at tscm_hwdep_read_locked()
> 
> warning: context imbalance in tscm_hwdep_read_locked() - unexpected unlock
> 
> The root cause is the missing annotation at tscm_hwdep_read_locked()
> Add the missing __releases(&tscm->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  sound/firewire/tascam/tascam-hwdep.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks for your care of the warning. Although I have found it, I had
no idea to suppress it.

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
> index 9801e33e7f2a..6f38335fe10b 100644
> --- a/sound/firewire/tascam/tascam-hwdep.c
> +++ b/sound/firewire/tascam/tascam-hwdep.c
> @@ -17,6 +17,7 @@
>  
>  static long tscm_hwdep_read_locked(struct snd_tscm *tscm, char __user *buf,
>  				   long count, loff_t *offset)
> +	__releases(&tscm->lock)
>  {
>  	struct snd_firewire_event_lock_status event = {
>  		.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS,
> -- 
> 2.24.1
> 

