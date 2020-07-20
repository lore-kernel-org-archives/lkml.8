Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A45C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AF922B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0OWXQcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGTGnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:43:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0BC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:43:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so16591252wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXqEhTXR7f15M+ETT6xxihVQYDZvnw82jJnCoYv66OQ=;
        b=j0OWXQcBB6b12mYYNfZCmZo4lwzWC+e4V2TZmo7gQEAlG+rM4SiggasB4o7Vw2ee/i
         OS5dtDYWKrBSCt43PMgsmEa/VORwZ5ZShQaH36qPTBfQGux8jzjjxu6ovVFXFV5QJ0Rx
         nCP/2jQSm2Vp76lEGZ3Gnc6Cd4JnuAqVepzMgO1BLsVMiN9ByStPp8ZcnunkJVDaL4oC
         l2xqdG2v17qPJLv7eE1WErfdjY2YQR2MFagXOwpGTlclVhIf5ZPrD99KS0qWFoXzViqv
         1758PWgD0mVzb4X5NII9pkX1M+xScO7xo1nXYRHrRFi6kol3Mkl1xhWCrdl8N3GoSZ/s
         rlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXqEhTXR7f15M+ETT6xxihVQYDZvnw82jJnCoYv66OQ=;
        b=DwpF3yFV18dpwrrRiPq5QxPRYHk0rfbaPj8mWttL48XHS2Prx1A40vscuB6qaS0EDf
         RWFUp7hK5wwNUlEYt2IGIdxwtnCRAlzQl1RrLntiHwT3xYYheaLS6tvbksMnbHRz8kqE
         PpfPMZkxxAgG23oOQK0xg77YjyckRrvGpjzqyOS2l9z1+DvUjz4nzUo9ezU8mDIvFSCv
         pDnDflPXsEMthr5BtBrwCbQYFseoHMdnVmgL38UnHhTvAftyKWZn+BJPd4jv/2wEZ71L
         fwEQqLt77K6LdoaBCZ/WXzZdOFvs+0qc3gJDO4zcq3Nk+pxMDjUe1KkY7aKgzi4aKh+n
         y8Nw==
X-Gm-Message-State: AOAM530oc92gGvcdlY7NYjK5O3hyPzebPdUBR6NwHvHgQrRaT2jgnuqr
        mGC3OUnmO1usuZbITgxJ5y7Ccw==
X-Google-Smtp-Source: ABdhPJxqlkFgiHcW6HoK9P6FdAfc4q4b11yPx76qrO9C/mDNKYP05TEPTYQ+2u3/KQcuIN4T2nH/Sw==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr653372wrv.86.1595227389648;
        Sun, 19 Jul 2020 23:43:09 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id c194sm30342642wme.8.2020.07.19.23.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 23:43:08 -0700 (PDT)
Date:   Mon, 20 Jul 2020 08:43:03 +0200
From:   Marco Elver <elver@google.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200720064303.GA2144711@elver.google.com>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
 <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719034312.GA566736@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:43PM +0900, Sergey Senozhatsky wrote:
> Hi Marco,
> 
> On (20/07/18 14:10), Marco Elver wrote:
> > 
> > It seems this causes a regression observed at least with newline-only
> > printks. I noticed this during -next testing because various debugging
> > tools (K*SAN, lockdep, etc.) use e.g. pr_{err,warn,info}("\n") to format
> > reports.
> > 
> > Without wanting to wait for a report from one of these debugging tools,
> > a simple reproducer is below. Without this patch, the expected newline
> > is printed.
> 
> Empty/blank lines carry no valuable payload, could you please explain
> why do you consider this to be a regression?

Empty/blank lines are visually valuable.

Did I miss a discussion somewhere that this change is acceptable?
Unfortunately, I can't find it mentioned in the commit message, and
therefore assumed it's a regression.

As I said, a number of debugging tools use them to format reports to be
more readable (visually separate title and report body, and separate
parts of the report). Also, such reports are often parsed by CI systems,
and by changing the reports, these CI systems may break. But those are
just the usecases I'm acutely aware of -- please see a full list of
newline-print users below.

Breaking the observable behaviour of a widely used interface such as
printk doesn't seem right. Where the newline-print is inappropriate,
wouldn't removing that newline-print be more appropriate (instead of
forcing this behaviour on everyone)?

Thanks,
-- Marco

------ >8 ------

$> git grep -En '\<(printk|pr_err|pr_warn|pr_info)\>\("\\n"\)'
arch/alpha/kernel/core_wildfire.c:650:	printk("\n");
arch/alpha/kernel/core_wildfire.c:658:	printk("\n");
arch/alpha/kernel/traps.c:120:	printk("\n");
arch/arm/mach-footbridge/dc21285.c:168:		printk("\n");
arch/arm/mach-footbridge/dc21285.c:185:	printk("\n");
arch/arm/mach-footbridge/dc21285.c:214:	printk("\n");
arch/arm/mach-footbridge/dc21285.c:229:	printk("\n");
arch/arm/plat-orion/mpp.c:44:	printk("\n");
arch/arm/plat-orion/mpp.c:81:	printk("\n");
arch/arm/probes/kprobes/test-core.c:576:	pr_info("\n");
arch/c6x/kernel/traps.c:30:	pr_err("\n");
arch/h8300/kernel/process.c:101:		printk("\n");
arch/h8300/kernel/traps.c:84:	pr_info("\n");
arch/h8300/kernel/traps.c:93:	pr_info("\n");
arch/ia64/kernel/acpi.c:514:		printk("\n");
arch/ia64/kernel/process.c:105:	printk("\n");
arch/ia64/kernel/sal.c:173:	printk("\n");
arch/ia64/kernel/time.c:306:		printk("\n");
arch/ia64/kernel/unaligned.c:48:	printk("\n");
arch/m68k/mm/kmap.c:283:	printk("\n");
arch/m68k/mm/motorola.c:383:	printk("\n");
arch/microblaze/pci/xilinx_pci.c:109:			pr_info("\n");
arch/mips/jazz/jazzdma.c:170:		printk("\n");
arch/mips/jazz/jazzdma.c:276:		printk("\n");
arch/mips/jazz/jazzdma.c:345:	printk("\n");
arch/mips/jazz/jazzdma.c:351:	printk("\n");
arch/mips/kernel/sysrq.c:31:	pr_info("\n");
arch/mips/kernel/sysrq.c:33:	pr_info("\n");
arch/mips/kernel/traps.c:378:	printk("\n");
arch/mips/kernel/traps.c:1588:		pr_info("\n");
arch/mips/kvm/tlb.c:81:	pr_info("\n");
arch/mips/lib/dump_tlb.c:187:	printk("\n");
arch/mips/lib/r3k_dump_tlb.c:67:	printk("\n");
arch/mips/math-emu/ieee754d.c:58:	printk("\n");
arch/mips/math-emu/ieee754d.c:97:	printk("\n");
arch/mips/mm/cerr-sb1.c:74:	printk("\n");
arch/mips/mm/cerr-sb1.c:85:	printk("\n");
arch/mips/mm/cerr-sb1.c:126:	printk("\n");
arch/mips/mm/cerr-sb1.c:416:			printk("\n");
arch/mips/mm/cerr-sb1.c:561:			printk("\n");
arch/mips/netlogic/xlr/fmn-config.c:64:	pr_info("\n");
arch/mips/netlogic/xlr/fmn-config.c:78:	pr_info("\n");
arch/mips/sni/setup.c:106:			printk("\n");
arch/openrisc/kernel/traps.c:120:	printk("\n");
arch/openrisc/kernel/traps.c:168:	printk("\n");
arch/openrisc/kernel/traps.c:183:	printk("\n");
arch/openrisc/kernel/traps.c:196:	printk("\n");
arch/parisc/kernel/drivers.c:1007:	pr_info("\n");
arch/parisc/kernel/pci-dma.c:70:	printk("\n");
arch/parisc/kernel/traps.c:452:	printk("\n");
arch/parisc/mm/fault.c:245:	pr_warn("\n");
arch/powerpc/kernel/traps.c:213:	printk("\n");
arch/powerpc/math-emu/fabs.c:15:	printk("\n");
arch/powerpc/math-emu/fctiw.c:24:	printk("\n");
arch/powerpc/math-emu/fctiwz.c:31:	printk("\n");
arch/powerpc/math-emu/fmr.c:15:	printk("\n");
arch/powerpc/math-emu/fnabs.c:15:	printk("\n");
arch/powerpc/math-emu/fneg.c:15:	printk("\n");
arch/powerpc/math-emu/lfd.c:17:	printk("\n");
arch/powerpc/math-emu/stfd.c:13:	printk("\n");
arch/powerpc/mm/book3s64/slb.c:271:			pr_err("\n");
arch/powerpc/mm/nohash/44x.c:194:			printk("\n");
arch/powerpc/platforms/52xx/efika.c:111:	printk("\n");
arch/powerpc/platforms/chrp/pci.c:257:		printk("\n");
arch/powerpc/platforms/embedded6xx/ls_uart.c:53:	printk("\n");
arch/powerpc/platforms/powermac/pfunc_core.c:88:	printk("\n");
arch/powerpc/platforms/ps3/setup.c:100:	printk("\n");
arch/powerpc/platforms/ps3/setup.c:103:	printk("\n");
arch/sh/drivers/pci/common.c:137:		printk("\n");
arch/sh/drivers/pci/common.c:146:		printk("\n");
arch/sh/drivers/pci/pci-sh7780.c:151:	printk("\n");
arch/sh/kernel/disassemble.c:567:		printk("\n");
arch/sh/kernel/disassemble.c:570:	printk("\n");
arch/sh/kernel/process_32.c:33:	printk("\n");
arch/sh/kernel/process_32.c:44:	printk("\n");
arch/sparc/kernel/perf_event.c:1602:	pr_info("\n");
arch/sparc/kernel/setup_32.c:383:	printk("\n");
arch/sparc/kernel/traps_32.c:44:	printk("\n");
arch/sparc/kernel/traps_64.c:2435:	printk("\n");
arch/sparc/kernel/traps_64.c:2452:	printk("\n");
arch/um/drivers/daemon_kern.c:39:	printk("\n");
arch/um/drivers/slirp_kern.c:44:	printk("\n");
arch/um/drivers/vde_kern.c:36:	printk("\n");
arch/um/os-Linux/skas/mem.c:101:			printk("\n");
arch/x86/events/core.c:1428:		pr_info("\n");
arch/x86/kernel/apm_32.c:2305:		printk("\n");
arch/x86/kernel/cpu/mtrr/cleanup.c:768:				pr_info("\n");
arch/x86/um/sysrq_32.c:17:        printk("\n");
arch/x86/um/sysrq_64.c:18:	printk("\n");
block/genhd.c:1115:				printk("\n");
drivers/ata/pata_marvell.c:50:	printk("\n");
drivers/ata/sata_mv.c:1258:		printk("\n");
drivers/ata/sata_mv.c:1275:		printk("\n");
drivers/atm/eni.c:1723:		printk("\n");
drivers/atm/eni.c:1734:			printk("\n");
drivers/atm/idt77252.c:543:	printk("\n");
drivers/atm/idt77252.c:1281:			printk("\n");
drivers/atm/idt77252.c:3494:	printk("\n");
drivers/atm/iphase.c:1347:          printk("\n");)
drivers/atm/iphase.c:2413:        printk("\n");  
drivers/atm/iphase.c:3001:        printk("\n");)
drivers/block/floppy.c:1830:	pr_info("\n");
drivers/block/floppy.c:1867:	pr_info("\n");
drivers/block/paride/bpck.c:340:	    printk("\n");
drivers/block/paride/pcd.c:590:		printk("\n");
drivers/block/paride/pd.c:294:	printk("\n");
drivers/block/paride/pf.c:585:		printk("\n");
drivers/block/paride/pg.c:349:		printk("\n");
drivers/block/paride/pg.c:415:		printk("\n");
drivers/block/paride/pt.c:477:		printk("\n");
drivers/block/umem.c:200:		printk("\n");
drivers/block/umem.c:226:	printk("\n");
drivers/block/xsysace.c:384:		printk("\n");
drivers/bluetooth/dtl1_cs.c:188:	printk("\n");
drivers/char/applicom.c:333:				printk("\n");
drivers/char/applicom.c:420:		printk("\n");
drivers/char/applicom.c:533:		printk("\n");
drivers/char/applicom.c:820:				printk("\n");
drivers/char/dtlk.c:457:				printk("\n");
drivers/char/dtlk.c:460:				printk("\n");
drivers/char/dtlk.c:483:				printk("\n");
drivers/char/dtlk.c:486:				printk("\n");
drivers/char/dtlk.c:530:	   printk("\n");
drivers/char/pcmcia/synclink_cs.c:3825:		printk("\n");
drivers/crypto/hifn_795x.c:1833:			pr_info("\n");
drivers/gpu/drm/i915/gvt/cmd_parser.c:698:	pr_err("\n");
drivers/i2c/busses/i2c-viapro.c:116:		printk("\n");
drivers/i2c/busses/scx200_acb.c:358:	printk("\n");
drivers/ide/cmd640.c:376:	printk("\n");
drivers/infiniband/hw/mlx4/qp.c:3245:		pr_err("\n");
drivers/infiniband/hw/mthca/mthca_cmd.c:1802:					printk("\n");
drivers/infiniband/hw/mthca/mthca_cmd.c:1819:					printk("\n");
drivers/infiniband/hw/mthca/mthca_eq.c:614:				printk("\n");
drivers/infiniband/hw/mthca/mthca_mr.c:487:				printk("\n");
drivers/input/keyboard/lkkbd.c:380:		printk("\n");
drivers/input/mouse/appletouch.c:225:		printk("\n");						\
drivers/iommu/iommu-debugfs.c:35:		pr_warn("\n");
drivers/isdn/hardware/mISDN/hfcmulti.c:2338:				printk("\n");
drivers/isdn/hardware/mISDN/hfcsusb.c:900:					printk("\n");
drivers/isdn/hardware/mISDN/hfcsusb.c:924:					printk("\n");
drivers/isdn/hardware/mISDN/hfcsusb.c:1025:				printk("\n");
drivers/isdn/hardware/mISDN/hfcsusb.c:1119:		printk("\n");
drivers/isdn/hardware/mISDN/hfcsusb.c:1331:					printk("\n");
drivers/isdn/mISDN/dsp_cmx.c:174:		printk("\n");
drivers/macintosh/adb-iop.c:120:	printk("\n");
drivers/macintosh/adb-iop.c:181:	printk("\n");
drivers/macintosh/adb.c:120:        printk("\n");
drivers/macintosh/therm_windtunnel.c:395:	printk("\n");
drivers/media/dvb-frontends/mt312.c:78:		printk("\n");
drivers/media/dvb-frontends/mt312.c:102:		printk("\n");
drivers/media/pci/bt8xx/dst.c:550:	pr_err("\n");
drivers/media/tuners/mt2060.c:25:#define dprintk(args...) do { if (debug) {printk(KERN_DEBUG "MT2060: " args); printk("\n"); }} while (0)
drivers/media/tuners/mt2266.c:45:#define dprintk(args...) do { if (debug) {printk(KERN_DEBUG "MT2266: " args); printk("\n"); }} while (0)
drivers/message/fusion/mptdebug.h:158:	printk("\n");
drivers/message/fusion/mptdebug.h:175:			printk("\n");
drivers/message/fusion/mptdebug.h:178:	printk("\n");
drivers/message/fusion/mptdebug.h:192:	printk("\n");
drivers/message/fusion/mptdebug.h:205:			printk("\n");
drivers/message/fusion/mptdebug.h:208:	printk("\n");
drivers/message/fusion/mptdebug.h:222:	printk("\n");
drivers/message/fusion/mptdebug.h:236:	printk("\n");
drivers/message/fusion/mptdebug.h:250:			printk("\n");
drivers/message/fusion/mptdebug.h:253:	printk("\n");
drivers/message/fusion/mptdebug.h:267:			printk("\n");
drivers/message/fusion/mptdebug.h:270:	printk("\n");
drivers/message/fusion/mptsas.c:953:	dsaswideprintk(ioc, printk("\n"));
drivers/mfd/wm8350-core.c:42:	printk("\n"); \
drivers/mmc/host/wbsd.c:1718:	printk("\n");
drivers/mtd/nand/raw/diskonchip.c:317:		printk("\n");
drivers/mtd/nand/raw/diskonchip.c:467:		printk("\n");
drivers/mtd/nand/raw/diskonchip.c:500:		printk("\n");
drivers/mtd/tests/nandbiterrs.c:332:	printk("\n");
drivers/mtd/tests/subpagetest.c:113:		printk("\n");
drivers/mtd/tests/torturetest.c:442:		printk("\n");
drivers/net/appletalk/ltpc.c:322:		printk("\n");
drivers/net/appletalk/ltpc.c:583:					printk("\n");
drivers/net/appletalk/ltpc.c:911:		printk("\n");
drivers/net/appletalk/ltpc.c:921:		printk("\n");
drivers/net/ethernet/amd/7990.c:563:				printk("\n");
drivers/net/ethernet/amd/ni65.c:909:				printk("\n");
drivers/net/ethernet/amd/ni65.c:1144:	printk("\n");
drivers/net/ethernet/amd/pcnet32.c:2469:		printk("\n");
drivers/net/ethernet/apple/bmac.c:1351:	printk("\n");
drivers/net/ethernet/apple/mace.c:616:	printk("\n");
drivers/net/ethernet/dec/tulip/de4x5.c:5012:	    printk("\n");
drivers/net/ethernet/dec/tulip/de4x5.c:5349:	  printk("\n");
drivers/net/ethernet/dlink/sundance.c:1474:					printk("\n");
drivers/net/ethernet/dnet.c:500:	printk("\n");
drivers/net/ethernet/i825xx/sun3_82586.c:1185:			printk("\n");
drivers/net/ethernet/i825xx/sun3_82586.c:1187:	printk("\n");
drivers/net/ethernet/packetengines/hamachi.c:1691:					printk("\n");
drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c:812:			pr_info("\n");
drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c:815:	pr_info("\n");
drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c:820:			pr_info("\n");
drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c:823:	pr_info("\n");
drivers/net/ethernet/realtek/atp.c:291:		printk("\n");
drivers/net/ethernet/seeq/ether3.c:255:				printk("\n");
drivers/net/ethernet/stmicro/stmmac/enh_desc.c:437:	pr_info("\n");
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:289:	pr_info("\n");
drivers/net/ethernet/sun/sungem.c:2792:		printk("\n");
drivers/net/ethernet/ti/cpmac.c:220:				printk("\n");
drivers/net/ethernet/ti/cpmac.c:225:	printk("\n");
drivers/net/ethernet/ti/cpmac.c:235:	printk("\n");
drivers/net/ethernet/ti/cpmac.c:257:				printk("\n");
drivers/net/ethernet/ti/cpmac.c:262:	printk("\n");
drivers/net/ethernet/toshiba/tc35815.c:905:		printk("\n");
drivers/net/ethernet/toshiba/tc35815.c:1065:	printk("\n");
drivers/net/ethernet/toshiba/tc35815.c:1086:	printk("\n");
drivers/net/ethernet/toshiba/tc35815.c:1105:	printk("\n");
drivers/net/ethernet/toshiba/tc35815.c:1355:	printk("\n");
drivers/net/ethernet/via/via-velocity.h:1328:	printk("\n");\
drivers/net/ethernet/xscale/ixp4xx_eth.c:594:	printk("\n");
drivers/net/hamradio/scc.c:1476:	printk("\n");
drivers/net/hippi/rrunner.c:1286:				printk("\n");
drivers/net/hippi/rrunner.c:1289:		printk("\n");
drivers/net/hippi/rrunner.c:1303:				printk("\n");
drivers/net/hippi/rrunner.c:1306:		printk("\n");
drivers/net/sb1000.c:725:			printk("\n");
drivers/net/wan/ixp4xx_hss.c:566:	printk("\n");
drivers/net/wireless/broadcom/b43/main.c:1139:		printk("\n");
drivers/net/wireless/broadcom/b43/main.c:1934:				printk("\n");
drivers/net/wireless/broadcom/b43/main.c:1938:		printk("\n");
drivers/net/wireless/intersil/hostap/hostap_80211_rx.c:45:		printk("\n");
drivers/net/wireless/intersil/hostap/hostap_80211_rx.c:57:	printk("\n");
drivers/net/wireless/intersil/hostap/hostap_80211_tx.c:42:		printk("\n");
drivers/net/wireless/intersil/hostap/hostap_80211_tx.c:54:	printk("\n");
drivers/net/wireless/intersil/hostap/hostap_hw.c:2152:	printk("\n");
drivers/net/wireless/intersil/orinoco/orinoco_plx.c:151:	printk("\n");
drivers/net/wireless/intersil/prism54/islpci_mgt.c:46:	printk("\n");
drivers/net/wireless/marvell/libertas/defs.h:97:					printk("\n");
drivers/net/wireless/marvell/libertas/defs.h:103:		printk("\n");
drivers/net/wireless/ray_cs.c:648:		printk("\n");
drivers/net/wireless/ray_cs.c:2347:		printk("\n");
drivers/net/wireless/st/cw1200/cw1200_spi.c:105:	printk("\n");
drivers/net/wireless/st/cw1200/cw1200_spi.c:170:	printk("\n");
drivers/parisc/gsc.c:225:	printk("\n");
drivers/parisc/iosapic.c:633:	printk("\n");
drivers/parisc/iosapic.c:645:printk("\n");
drivers/parisc/lba_pci.c:1379:	printk("\n");
drivers/pcmcia/i82365.c:680:    if (base == 0) printk("\n");
drivers/scsi/53c700.c:832:		printk("\n");
drivers/scsi/53c700.c:863:	printk("\n");
drivers/scsi/53c700.c:917:		printk("\n");
drivers/scsi/NCR5380.c:2098:		printk("\n");
drivers/scsi/advansys.c:2489:		printk("\n");
drivers/scsi/aha152x.c:1739:					printk("\n");
drivers/scsi/aha1740.c:344:	printk("\n");
drivers/scsi/aha1740.c:439:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:2731:		printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:3953:					printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9611:		printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9722:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9766:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9776:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9786:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9797:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9806:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9833:			printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9843:			printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9864:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9876:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9880:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_core.c:9934:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_osm.c:793:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_osm.c:1821:			printk("\n");
drivers/scsi/aic7xxx/aic79xx_osm.c:1942:						printk("\n");
drivers/scsi/aic7xxx/aic79xx_osm.c:1945:				printk("\n");
drivers/scsi/aic7xxx/aic79xx_osm.c:2165:	printk("\n");
drivers/scsi/aic7xxx/aic79xx_pci.c:614:		printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7067:		printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7165:		printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7184:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7194:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7204:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7214:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7224:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7236:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7256:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7265:	printk("\n");
drivers/scsi/aic7xxx/aic7xxx_core.c:7279:		printk("\n");
drivers/scsi/aic7xxx/aic7xxx_osm.c:1745:			printk("\n");
drivers/scsi/aic7xxx/aic7xxx_osm.c:1849:						printk("\n");
drivers/scsi/aic7xxx/aic7xxx_osm.c:1852:				printk("\n");
drivers/scsi/aic7xxx/aic7xxx_osm.c:2062:	printk("\n");
drivers/scsi/arm/acornscsi.c:248:	printk("\n");
drivers/scsi/arm/acornscsi.c:538:	printk("\n");
drivers/scsi/arm/acornscsi.c:1395:    printk("\n");
drivers/scsi/arm/acornscsi.c:1476:    printk("\n");
drivers/scsi/arm/acornscsi.c:1870:    printk("\n");
drivers/scsi/arm/fas216.c:330:	printk("\n");
drivers/scsi/arm/fas216.c:344:	printk("\n");
drivers/scsi/arm/fas216.c:388:			printk("\n");
drivers/scsi/arm/fas216.c:391:		printk("\n");
drivers/scsi/arm/fas216.c:399:	printk("\n");
drivers/scsi/arm/fas216.c:1043:	printk("\n");
drivers/scsi/arm/fas216.c:1147:	printk("\n");
drivers/scsi/arm/fas216.c:1264:		printk("\n");
drivers/scsi/arm/fas216.c:1702:		printk("\n");
drivers/scsi/arm/fas216.c:2021://{ int i; for (i = 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[i]); printk("\n"); }
drivers/scsi/atp870u.c:337:			printk("\n");
drivers/scsi/atp870u.c:746:	printk("\n");
drivers/scsi/dc395x.c:2197:				printk("\n");
drivers/scsi/dc395x.c:2393:				printk("\n");
drivers/scsi/dc395x.c:3447:	printk("\n");
drivers/scsi/dc395x.c:4194:		printk("\n");
drivers/scsi/dpt_i2o.c:3160:	 printk("\n");
drivers/scsi/gdth.c:2720:        printk("\n");
drivers/scsi/gdth.c:3107:            printk("\n");
drivers/scsi/lpfc/lpfc_debugfs.c:5827:		pr_err("\n");
drivers/scsi/lpfc/lpfc_debugfs.c:5855:		pr_err("\n");
drivers/scsi/mesh.c:258:		printk("\n");
drivers/scsi/mesh.c:283:		printk("\n");
drivers/scsi/mesh.c:720:			printk("\n");
drivers/scsi/mesh.c:1170:		printk("\n");
drivers/scsi/mesh.c:1249:	printk("\n");
drivers/scsi/mpt3sas/mpt3sas_debug.h:165:	pr_info("\n");
drivers/scsi/mpt3sas/mpt3sas_debug.h:184:	pr_info("\n");
drivers/scsi/mpt3sas/mpt3sas_debug.h:203:	pr_info("\n");
drivers/scsi/ncr53c8xx.c:3672:	printk("\n");
drivers/scsi/nsp32_debug.c:137:	printk("\n");
drivers/scsi/nsp32_debug.c:225:	printk("\n");
drivers/scsi/nsp32_debug.c:254:	printk("\n");
drivers/scsi/nsp32_debug.c:259:		printk("\n");
drivers/scsi/pcmcia/nsp_debug.c:138:	printk("\n");
drivers/scsi/pcmcia/nsp_debug.c:212:	printk("\n");
drivers/scsi/pcmcia/sym53c500_cs.c:556:	VDEB(printk("\n"));
drivers/scsi/qla1280.c:3928:	printk("\n");
drivers/scsi/qla1280.c:3950:			printk("\n");
drivers/scsi/qla1280.c:3955:		printk("\n");
drivers/scsi/qla4xxx/ql4_83xx.c:1423:	DEBUG2(pr_info("\n"));
drivers/scsi/qla4xxx/ql4_83xx.c:1434:	DEBUG2(pr_info("\n"));
drivers/scsi/qla4xxx/ql4_83xx.c:1445:	DEBUG2(pr_info("\n"));
drivers/scsi/qla4xxx/ql4_83xx.c:1456:	DEBUG2(pr_info("\n"));
drivers/scsi/qla4xxx/ql4_83xx.c:1474:	DEBUG2(pr_info("\n"));
drivers/scsi/qla4xxx/ql4_83xx.c:1492:	DEBUG2(pr_info("\n"));
drivers/scsi/qla4xxx/ql4_dbg.c:25:			printk("\n");
drivers/scsi/wd33c93.c:2048:	printk("\n");
drivers/staging/rtl8192u/ieee80211/ieee80211.h:464:					printk("\n");                          \
drivers/staging/rtl8192u/ieee80211/ieee80211.h:466:			printk("\n");                                          \
drivers/staging/rtl8192u/r8192U.h:120:					printk("\n");			\
drivers/staging/rtl8192u/r8192U.h:122:			printk("\n");					\
drivers/staging/rtl8723bs/core/rtw_mlme.c:2387:			printk("\n");
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2189:		printk("\n");
drivers/staging/rtl8723bs/hal/hal_com.c:1651:			printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:1686:					printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:1708:					printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:1728:					printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:1747:					printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:901:			printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:904:	printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:972:			printk("\n");
drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:975:	printk("\n");
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:251:				printk("\n");
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:579:						printk("\n");*/
drivers/staging/wlan-ng/p80211netdev.c:989:		/* printk("\n"); */
drivers/staging/wlan-ng/p80211netdev.c:1031:		/* printk("\n"); */
drivers/tty/hvc/hvsi.c:203:	printk("\n");
drivers/tty/n_r3964.c:273:	printk("\n");
drivers/tty/serial/zs.c:203:		printk("\n");
drivers/tty/synclink.c:7437:		printk("\n");
drivers/tty/synclink_gt.c:568:		printk("\n");
drivers/tty/synclinkmp.c:5446:		printk("\n");
drivers/usb/atm/speedtch.c:625:		printk("\n");
drivers/usb/host/isp116x.h:572:		printk("\n");
drivers/usb/host/isp116x.h:584:		printk("\n");
drivers/usb/host/isp1362.h:903:				printk("\n");
drivers/usb/host/isp1362.h:913:			printk("\n");
drivers/usb/storage/sddr09.c:1478:		printk("\n");
drivers/video/fbdev/intelfb/intelfbhw.c:827:	printk("\n");
drivers/video/fbdev/intelfb/intelfbhw.c:834:	printk("\n");
drivers/video/fbdev/vesafb.c:343:			printk("\n");
drivers/w1/masters/ds2490.c:225:	pr_info("\n");
drivers/w1/masters/ds2490.c:347:		printk("\n");
drivers/w1/masters/ds2490.c:436:			printk("\n");
drivers/xen/xenbus/xenbus_probe_frontend.c:328:		printk("\n");
fs/btrfs/check-integrity.c:1689:		pr_info("\n");
fs/btrfs/check-integrity.c:2486:		printk("\n");
fs/cachefiles/internal.h:322:		pr_err("\n");						\
fs/cachefiles/internal.h:331:		pr_err("\n");						\
fs/cachefiles/internal.h:342:		pr_err("\n");						\
fs/cachefiles/internal.h:351:		pr_err("\n");						\
fs/cachefiles/namei.c:121:		pr_err("\n");
fs/cachefiles/namei.c:187:		pr_err("\n");
fs/cachefiles/namei.c:233:			pr_err("\n");
fs/dlm/dlm_internal.h:99:    printk("\n"); \
fs/ext2/xattr.c:79:		printk("\n"); \
fs/ext2/xattr.c:85:		printk("\n"); \
fs/fscache/internal.h:446:		pr_err("\n");					\
fs/fscache/internal.h:455:		pr_err("\n");					\
fs/fscache/internal.h:466:		pr_err("\n");					\
fs/fscache/internal.h:475:		pr_err("\n");					\
fs/jffs2/debug.c:428:	printk("\n");
fs/jffs2/debug.c:756:				printk("\n");
fs/jffs2/debug.c:766:	printk("\n");
fs/reiserfs/item_ops.c:617:	printk("\n");
fs/reiserfs/prints.c:471:			printk("\n");
fs/reiserfs/prints.c:473:	printk("\n");
fs/ubifs/debug.c:926:	pr_err("\n");
include/linux/hdlc.h:85:	printk("\n");
init/do_mounts.c:472:	printk("\n");
kernel/kcsan/report.c:314:	pr_err("\n");
kernel/kcsan/report.c:379:	pr_err("\n");
kernel/kcsan/report.c:397:		pr_err("\n");
kernel/kcsan/report.c:420:	pr_err("\n");
kernel/locking/lockdep.c:1644:	pr_warn("\n");
kernel/locking/lockdep.c:1974:		printk("\n");
kernel/locking/lockdep.c:2057:	pr_warn("\n");
kernel/locking/lockdep.c:2375:	pr_warn("\n");
kernel/locking/lockdep.c:2947:		printk("\n");
kernel/locking/lockdep.c:2955:	pr_warn("\n");
kernel/locking/lockdep.c:3323:	pr_warn("\n");
kernel/locking/lockdep.c:3384:	pr_warn("\n");
kernel/locking/lockdep.c:4053:	pr_warn("\n");
kernel/locking/lockdep.c:4240:	pr_warn("\n");
kernel/locking/lockdep.c:4456:	pr_warn("\n");
kernel/locking/lockdep.c:5107:	pr_warn("\n");
kernel/locking/lockdep.c:5736:	pr_warn("\n");
kernel/locking/lockdep.c:5794:	pr_warn("\n");
kernel/locking/lockdep.c:5833:	pr_warn("\n");
kernel/locking/lockdep.c:5860:		pr_warn("\n");
kernel/locking/lockdep.c:5882:	pr_warn("\n");
kernel/locking/rtmutex-debug.c:56:		printk("\n");
kernel/locking/rtmutex-debug.c:106:	pr_warn("\n");
kernel/sched/topology.c:49:			printk("\n");
kernel/trace/trace.c:3158:	pr_warn("\n");
mm/kasan/report.c:177:		pr_err("\n");
mm/kasan/report.c:181:			pr_err("\n");
mm/kasan/report.c:188:			pr_err("\n");
mm/kasan/report.c:193:			pr_err("\n");
mm/kasan/report.c:267:	pr_err("\n");
mm/kasan/report.c:368:	pr_err("\n");
mm/kasan/report.c:384:	pr_err("\n");
mm/kasan/report.c:476:	pr_err("\n");
mm/kasan/report.c:478:	pr_err("\n");
mm/kasan/report.c:510:	pr_err("\n");
mm/kasan/report.c:514:		pr_err("\n");
net/atm/lec.c:1185:	pr_info("\n");
