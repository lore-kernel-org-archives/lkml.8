Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C21C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714F920836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593185705;
	bh=61Aafhz/sebn21egwsMMGm+NbOzYRY3lUCbjT6P131s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=xffnBRUNnD5XHyeSLrVh3VySVrrDTcun+gb7Y5n16k6bi7O1SozrzuPbU+H4jL3z7
	 1NVHE6gmkAgmSjG/1R2t5ARLceDt/4aoHaobza8KUaL2J7fN/Y1jGA5WY1Ua3DVlhA
	 dWfPr8bDW5982avJZ8zzF2rO28BpnRY7VDeS0AOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgFZPfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgFZPfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:35:03 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D4B20706;
        Fri, 26 Jun 2020 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593185702;
        bh=61Aafhz/sebn21egwsMMGm+NbOzYRY3lUCbjT6P131s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Occ0hBEswS0KfEiDUn8Ab9ZytNfsRzopQVvidPVjfnoprbdKkxEYtVtiv7AB4u+7x
         rRslWJ6ZC1NEieDYKoiNI4ymI0qRxj0rhzBhDmIHlZhZylzJhDQHb6DkmqSoTYsRRJ
         Af7htNBpqd23xDGDeNA5qJUnVKXGwRseDDT/bess=
Date:   Fri, 26 Jun 2020 10:35:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kbuild-all@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v1 1/4] ide: use generic power management
Message-ID: <20200626153500.GA2895752@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006250611.HDgpcjeu%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 06:14:09AM +0800, kernel test robot wrote:
> Hi Vaibhav,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on ide/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Vaibhav-Gupta/drivers-ide-use-generic-power-management/20200625-013242
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git master
> config: x86_64-randconfig-a004-20200624 (attached as .config)

This auto build testing is a great service, but is there any way to
tweak the info above to make it easier to reproduce the problem?

I tried to checkout the source that caused these errors, but failed.
This is probably because I'm not a git expert, but maybe others are in
the same boat.  For example, I tried:

  $ git remote add kbuild https://github.com/0day-ci/linux/commits/Vaibhav-Gupta/drivers-ide-use-generic-power-management/20200625-013242
  $ git fetch kbuild
  fatal: repository 'https://github.com/0day-ci/linux/commits/Vaibhav-Gupta/drivers-ide-use-generic-power-management/20200625-013242/' not found

I also visited the github URL in a browser, and I'm sure there must be
information there that would let me fetch the source, but I don't know
enough about github to find it.

The report doesn't include a SHA1, so even if I *did* manage to fetch
the sources, I wouldn't be able to validate they were the *correct*
ones.

> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce (this is a W=1 build):
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "ide_pci_pm_ops" [drivers/ide/ide-pci-generic.ko] undefined!
> >> ERROR: modpost: "ide_pci_pm_ops" [drivers/ide/serverworks.ko] undefined!
> >> ERROR: modpost: "ide_pci_pm_ops" [drivers/ide/piix.ko] undefined!
> >> ERROR: modpost: "ide_pci_pm_ops" [drivers/ide/pdc202xx_old.ko] undefined!
> >> ERROR: modpost: "ide_pci_pm_ops" [drivers/ide/ns87415.ko] undefined!
> >> ERROR: modpost: "ide_pci_pm_ops" [drivers/ide/hpt366.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


