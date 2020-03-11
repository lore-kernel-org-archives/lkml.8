Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35191 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbgCKD0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:26:53 -0400
Date: Wed, 11 Mar 2020 12:19:38 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:FIREWIRE AUDIO DRIVERS and IEC 61883-1/6 PACKET..."
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 7/8] ALSA: firewire-tascam: Add missing annotation for
 tscm_hwdep_read_queue()
Message-ID: <20200311031937.GB8197@workstation>
References: <0/8>
 <20200311010908.42366-1-jbi.octave@gmail.com>
 <20200311010908.42366-8-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311010908.42366-8-jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311031938.4b82V4Z6sc7n1y5OL0vzKb92_D9Glta2fU4DCXaYQAk@z>

On Wed, Mar 11, 2020 at 01:09:07AM +0000, Jules Irenge wrote:
> Sparse reports a warning at tscm_hwdep_read_queue()
> 
> warning: context imbalance in tscm_hwdep_read_queue() - unexpected unlock
> 
> The root cause is the missing annotation at tscm_hwdep_read_queue()
> Add the missing __releases(&tscm->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  sound/firewire/tascam/tascam-hwdep.c | 1 +
>  1 file changed, 1 insertion(+)
 
This looks good.

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
> index c29a97f6f638..9801e33e7f2a 100644
> --- a/sound/firewire/tascam/tascam-hwdep.c
> +++ b/sound/firewire/tascam/tascam-hwdep.c
> @@ -36,6 +36,7 @@ static long tscm_hwdep_read_locked(struct snd_tscm *tscm, char __user *buf,
>  
>  static long tscm_hwdep_read_queue(struct snd_tscm *tscm, char __user *buf,
>  				  long remained, loff_t *offset)
> +	__releases(&tscm->lock)
>  {
>  	char __user *pos = buf;
>  	unsigned int type = SNDRV_FIREWIRE_EVENT_TASCAM_CONTROL;
> -- 
> 2.24.1


Regards

Takashi Sakamoto

