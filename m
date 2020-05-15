Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F28D207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589526290;
	bh=upNdoDczq0LfOqv/wUOK/hzajMfTetVf10l01Gag/Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MpT6vlOK9BQl9WECaph7wwM1njsVonRrGwG3r2uMS1lLyJ2805utt1EfX4lLk3erY
	 a0/Qf1bDQKmpAJroiWudP/7im63eUyZxe0Kp/eFXym1E5JiFF2uKP1YAhPw9YAvDMN
	 Pa3gyH990cU1tOhogQ8MbL26HFnvKzWOLVhc5nu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgEOHEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgEOHEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:04:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F27206F1;
        Fri, 15 May 2020 07:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589526288;
        bh=upNdoDczq0LfOqv/wUOK/hzajMfTetVf10l01Gag/Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMRETnVnkQEW3dtg+dPNVeiStdHFenIHmCY1Ph/Z4njZNYmMxKKz/M2LnoFVvBdvz
         Ng36mEKLZka2tF5ACfdGCWOoKN4tA4x495KM3lyewy5VCA9K9QeLTDZ4ViAIwUru9B
         fTNTF76NRSSrxVoHbF9GuZL3p4YUgtOIvPeK9TSI=
Date:   Fri, 15 May 2020 09:04:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulhsia <paulhsia@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcm: fix incorrect hw_base increase
Message-ID: <20200515070446.GA1226131@kroah.com>
References: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:09:39PM +0800, Brent Lu wrote:
> The hw_base will be increased by runtime->buffer_size frames
> unconditionally if the runtime->status->hw_ptr is not updated for over
> half of buffer time. As the hw_base increases, so does the
> runtime->status->hw_ptr which could lead to invalid return value when
> user space program calls snd_pcm_avail() function.
> 
> By updating runtime->hw_ptr_jiffies each time the HWSYNC is called,
> the hw_base will keep the same when buffer stall happens, so does the
> hw_ptr.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>  sound/core/pcm_lib.c | 1 +
>  1 file changed, 1 insertion(+)

Is this a bugfix needed for older kernels as well?  When did this issue
show up?

thanks,

greg k-h
