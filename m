Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65334C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368CD20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591012438;
	bh=lmCGS2ljnhIMFqFkgamCfR7kwSg+m4kDvHq+YhiNCmk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Ly5tJcHFeS9wVk/6rYli42IWgqPfHIrnsWyFUc5BKUXpIwXDxAPQZNr3frGO4v5dR
	 GVMLnEhMoAy1usTujqIl29rf1w4C3dpFZ117PcsZceI3ekCUU9XHa7LgtbiIN/9QUw
	 1xflEvzkKkTg9x46pXgY2aMO4x1WMWiP5umOr9Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgFALx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:53:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DFA206E2;
        Mon,  1 Jun 2020 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591012436;
        bh=lmCGS2ljnhIMFqFkgamCfR7kwSg+m4kDvHq+YhiNCmk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TnhqqSt0nYRPMZRf+ilz2wdb7exbv7qapKoigSR5XcbUS6KxA6LEhDe1JYs3WrqCV
         3R5SdMxMvLXAQ52vE5N84Qqo3ylboIli58e8DOkzQqTKXQUyoNn+GIByP0zq8g8K5l
         0jgWznhmoZRaSODS6Bg6fsdo4eeeSw3h1oMGsXM8=
Date:   Mon, 01 Jun 2020 12:53:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Todd Kjos <tkjos@google.com>, Takashi Iwai <tiwai@suse.com>,
        Alistair Delva <adelva@google.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
In-Reply-To: <20200529213823.98812-1-john.stultz@linaro.org>
References: <20200529213823.98812-1-john.stultz@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: q6asm-dai: kCFI fix
Message-Id: <159101243412.15283.14423556802231850901.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 21:38:23 +0000, John Stultz wrote:
> Fixes the following kCFI crash seen on db845c, caused
> by the function prototypes not matching the callback
> function prototype.
> 
> [   82.585661] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000001
> [   82.595387] Mem abort info:
> [   82.599463]   ESR = 0x96000005
> [   82.602658]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   82.608177]   SET = 0, FnV = 0
> [   82.611829]   EA = 0, S1PTW = 0
> [   82.615369] Data abort info:
> [   82.618751]   ISV = 0, ISS = 0x00000005
> [   82.622641]   CM = 0, WnR = 0
> [   82.625774] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000174259000
> [   82.632292] [0000000000000001] pgd=0000000000000000, pud=0000000000000000
> [   82.639167] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [   82.644795] Modules linked in: hci_uart btqca xhci_plat_hcd xhci_pci_renesas xhci_pci xhci_hcd wcn36xx wcnss_ctrl wcd934x vctrl_regulator ufs_qcom syscon_reboot_e
> [   82.644927]  qcom_apcs_ipc_mailbox q6asm_dai q6routing q6asm q6afe_dai q6adm q6afe q6core q6dsp_common pm8941_pwrkey pm8916_wdt platform_mhu pinctrl_spmi_mpp pine
> [   82.812982] CPU: 3 PID: 240 Comm: kworker/u16:4 Tainted: G        W         5.6.0-rc7-mainline-00960-g0c34353d11b9-dirty #1
> [   82.824201] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   82.829937] Workqueue: qcom_apr_rx apr_rxwq [apr]
> [   82.834698] pstate: 80c00005 (Nzcv daif +PAN +UAO)
> [   82.839553] pc : __cfi_check_fail+0x4/0x1c [q6asm_dai]
> [   82.844754] lr : __cfi_check+0x3a8/0x3b0 [q6asm_dai]
> [   82.849767] sp : ffffffc0105f3c20
> [   82.853123] x29: ffffffc0105f3c30 x28: 0000000000000020
> [   82.858489] x27: ffffff80f4588400 x26: ffffff80f458ec94
> [   82.863854] x25: ffffff80f458ece8 x24: ffffffe3670c7000
> [   82.869220] x23: ffffff8094bb7b34 x22: ffffffe367137000
> [   82.874585] x21: bd07909b332eada6 x20: 0000000000000001
> [   82.879950] x19: ffffffe36713863c x18: ffffff80f8df4430
> [   82.885316] x17: 0000000000000001 x16: ffffffe39d15e660
> [   82.890681] x15: 0000000000000001 x14: 0000000000000027
> [   82.896047] x13: 0000000000000000 x12: ffffffe39e6465a0
> [   82.901413] x11: 0000000000000051 x10: 000000000000ffff
> [   82.906779] x9 : 000ffffffe366c19 x8 : c3c5f18762d1ceef
> [   82.912145] x7 : 0000000000000000 x6 : ffffffc010877698
> [   82.917511] x5 : ffffffc0105f3c00 x4 : 0000000000000000
> [   82.922877] x3 : 0000000000000000 x2 : 0000000000000001
> [   82.928243] x1 : ffffffe36713863c x0 : 0000000000000001
> [   82.933610] Call trace:
> [   82.936099]  __cfi_check_fail+0x4/0x1c [q6asm_dai]
> [   82.940955]  q6asm_srvc_callback+0x22c/0x618 [q6asm]
> [   82.945973]  apr_rxwq+0x1a8/0x27c [apr]
> [   82.949861]  process_one_work+0x2e8/0x54c
> [   82.953919]  worker_thread+0x27c/0x4d4
> [   82.957715]  kthread+0x144/0x154
> [   82.960985]  ret_from_fork+0x10/0x18
> [   82.964603] Code: a8c37bfd f85f8e5e d65f03c0 b40000a0 (39400008)
> [   82.970762] ---[ end trace 410accb839617143 ]---
> [   82.975429] Kernel panic - not syncing: Fatal exception

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: q6asm-dai: kCFI fix
      commit: a6b675a89e51a1cdad0481b809b7840d3f86e4b5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
