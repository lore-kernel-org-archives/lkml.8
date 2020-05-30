Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E83DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360AF2076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgE3Vwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 17:52:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:30790 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbgE3Vwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 17:52:36 -0400
IronPort-SDR: +14XgNBlYa1j9L/RcOjEvBDemYHMN0CTxJwcelhFkTBIrTubt2A0hX44Cg+Knf1QLz4d5kp+d1
 PyIbLtmipJhw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 14:33:33 -0700
IronPort-SDR: 9AGT3aP+qRnfedrddEsHbKN8w3A3ai1n7t7EjcgWxEv5CIRCS0g/NRg+l/ndbzdjlMTHrNJL62
 OqP4/GqXBbfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,454,1583222400"; 
   d="gz'50?scan'50,208,50";a="469865167"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 May 2020 14:33:31 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jf96h-0000nv-0x; Sat, 30 May 2020 21:33:31 +0000
Date:   Sun, 31 May 2020 05:32:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Thomas, Bogendoerfer," <tbogendoerfer@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>
Subject: arch/mips/sgi-ip27/ip27-hubio.c:30:15: warning: no previous
 prototype for 'hub_pio_map'
Message-ID: <202005310549.dVSWxuGH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   86852175b016f0c6873dcbc24b93d12b7b246612
commit: b78e9d63a3b6307b6b786e6ba189d3978b60ceb5 MIPS: SGI-IP27: use asm/sn/agent.h for including HUB related stuff
date:   5 months ago
config: mips-ip27_defconfig (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b78e9d63a3b6307b6b786e6ba189d3978b60ceb5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> arch/mips/sgi-ip27/ip27-hubio.c:30:15: warning: no previous prototype for 'hub_pio_map' [-Wmissing-prototypes]
30 | unsigned long hub_pio_map(nasid_t nasid, xwidgetnum_t widget,
|               ^~~~~~~~~~~
>> arch/mips/sgi-ip27/ip27-hubio.c:175:6: warning: no previous prototype for 'hub_pio_init' [-Wmissing-prototypes]
175 | void hub_pio_init(nasid_t nasid)
|      ^~~~~~~~~~~~

vim +/hub_pio_map +30 arch/mips/sgi-ip27/ip27-hubio.c

^1da177e4c3f41 Linus Torvalds      2005-04-16   20  
^1da177e4c3f41 Linus Torvalds      2005-04-16   21  /**
^1da177e4c3f41 Linus Torvalds      2005-04-16   22   * hub_pio_map	-  establish a HUB PIO mapping
^1da177e4c3f41 Linus Torvalds      2005-04-16   23   *
^1da177e4c3f41 Linus Torvalds      2005-04-16   24   * @hub:	hub to perform PIO mapping on
^1da177e4c3f41 Linus Torvalds      2005-04-16   25   * @widget:	widget ID to perform PIO mapping for
^1da177e4c3f41 Linus Torvalds      2005-04-16   26   * @xtalk_addr: xtalk_address that needs to be mapped
^1da177e4c3f41 Linus Torvalds      2005-04-16   27   * @size:	size of the PIO mapping
^1da177e4c3f41 Linus Torvalds      2005-04-16   28   *
^1da177e4c3f41 Linus Torvalds      2005-04-16   29   **/
4bf841ebf17aaa Thomas Bogendoerfer 2019-10-03  @30  unsigned long hub_pio_map(nasid_t nasid, xwidgetnum_t widget,
^1da177e4c3f41 Linus Torvalds      2005-04-16   31  			  unsigned long xtalk_addr, size_t size)
^1da177e4c3f41 Linus Torvalds      2005-04-16   32  {
^1da177e4c3f41 Linus Torvalds      2005-04-16   33  	unsigned i;
^1da177e4c3f41 Linus Torvalds      2005-04-16   34  
^1da177e4c3f41 Linus Torvalds      2005-04-16   35  	/* use small-window mapping if possible */
^1da177e4c3f41 Linus Torvalds      2005-04-16   36  	if ((xtalk_addr % SWIN_SIZE) + size <= SWIN_SIZE)
^1da177e4c3f41 Linus Torvalds      2005-04-16   37  		return NODE_SWIN_BASE(nasid, widget) + (xtalk_addr % SWIN_SIZE);
^1da177e4c3f41 Linus Torvalds      2005-04-16   38  
^1da177e4c3f41 Linus Torvalds      2005-04-16   39  	if ((xtalk_addr % BWIN_SIZE) + size > BWIN_SIZE) {
^1da177e4c3f41 Linus Torvalds      2005-04-16   40  		printk(KERN_WARNING "PIO mapping at hub %d widget %d addr 0x%lx"
^1da177e4c3f41 Linus Torvalds      2005-04-16   41  				" too big (%ld)\n",
^1da177e4c3f41 Linus Torvalds      2005-04-16   42  				nasid, widget, xtalk_addr, size);
^1da177e4c3f41 Linus Torvalds      2005-04-16   43  		return 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16   44  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16   45  
^1da177e4c3f41 Linus Torvalds      2005-04-16   46  	xtalk_addr &= ~(BWIN_SIZE-1);
^1da177e4c3f41 Linus Torvalds      2005-04-16   47  	for (i = 0; i < HUB_NUM_BIG_WINDOW; i++) {
4bf841ebf17aaa Thomas Bogendoerfer 2019-10-03   48  		if (test_and_set_bit(i, hub_data(nasid)->h_bigwin_used))
^1da177e4c3f41 Linus Torvalds      2005-04-16   49  			continue;
^1da177e4c3f41 Linus Torvalds      2005-04-16   50  
^1da177e4c3f41 Linus Torvalds      2005-04-16   51  		/*
^1da177e4c3f41 Linus Torvalds      2005-04-16   52  		 * The code below does a PIO write to setup an ITTE entry.
^1da177e4c3f41 Linus Torvalds      2005-04-16   53  		 *
^1da177e4c3f41 Linus Torvalds      2005-04-16   54  		 * We need to prevent other CPUs from seeing our updated
^1da177e4c3f41 Linus Torvalds      2005-04-16   55  		 * memory shadow of the ITTE (in the piomap) until the ITTE
^1da177e4c3f41 Linus Torvalds      2005-04-16   56  		 * entry is actually set up; otherwise, another CPU might
^1da177e4c3f41 Linus Torvalds      2005-04-16   57  		 * attempt a PIO prematurely.
^1da177e4c3f41 Linus Torvalds      2005-04-16   58  		 *
^1da177e4c3f41 Linus Torvalds      2005-04-16   59  		 * Also, the only way we can know that an entry has been
^1da177e4c3f41 Linus Torvalds      2005-04-16   60  		 * received  by the hub and can be used by future PIO reads/
^1da177e4c3f41 Linus Torvalds      2005-04-16   61  		 * writes is by reading back the ITTE entry after writing it.
^1da177e4c3f41 Linus Torvalds      2005-04-16   62  		 *
^1da177e4c3f41 Linus Torvalds      2005-04-16   63  		 * For these two reasons, we PIO read back the ITTE entry
^1da177e4c3f41 Linus Torvalds      2005-04-16   64  		 * after we write it.
^1da177e4c3f41 Linus Torvalds      2005-04-16   65  		 */
^1da177e4c3f41 Linus Torvalds      2005-04-16   66  		IIO_ITTE_PUT(nasid, i, HUB_PIO_MAP_TO_MEM, widget, xtalk_addr);
db0e7d4e42b055 Thomas Bogendoerfer 2019-02-19   67  		__raw_readq(IIO_ITTE_GET(nasid, i));
^1da177e4c3f41 Linus Torvalds      2005-04-16   68  
^1da177e4c3f41 Linus Torvalds      2005-04-16   69  		return NODE_BWIN_BASE(nasid, widget) + (xtalk_addr % BWIN_SIZE);
^1da177e4c3f41 Linus Torvalds      2005-04-16   70  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16   71  
^1da177e4c3f41 Linus Torvalds      2005-04-16   72  	printk(KERN_WARNING "unable to establish PIO mapping for at"
^1da177e4c3f41 Linus Torvalds      2005-04-16   73  			" hub %d widget %d addr 0x%lx\n",
^1da177e4c3f41 Linus Torvalds      2005-04-16   74  			nasid, widget, xtalk_addr);
^1da177e4c3f41 Linus Torvalds      2005-04-16   75  	return 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16   76  }
^1da177e4c3f41 Linus Torvalds      2005-04-16   77  
^1da177e4c3f41 Linus Torvalds      2005-04-16   78  
^1da177e4c3f41 Linus Torvalds      2005-04-16   79  /*
^1da177e4c3f41 Linus Torvalds      2005-04-16   80   * hub_setup_prb(nasid, prbnum, credits, conveyor)
^1da177e4c3f41 Linus Torvalds      2005-04-16   81   *
^1da177e4c3f41 Linus Torvalds      2005-04-16   82   *	Put a PRB into fire-and-forget mode if conveyor isn't set.  Otherwise,
^1da177e4c3f41 Linus Torvalds      2005-04-16   83   *	put it into conveyor belt mode with the specified number of credits.
^1da177e4c3f41 Linus Torvalds      2005-04-16   84   */
^1da177e4c3f41 Linus Torvalds      2005-04-16   85  static void hub_setup_prb(nasid_t nasid, int prbnum, int credits)
^1da177e4c3f41 Linus Torvalds      2005-04-16   86  {
^1da177e4c3f41 Linus Torvalds      2005-04-16   87  	iprb_t prb;
^1da177e4c3f41 Linus Torvalds      2005-04-16   88  	int prb_offset;
^1da177e4c3f41 Linus Torvalds      2005-04-16   89  
^1da177e4c3f41 Linus Torvalds      2005-04-16   90  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16   91  	 * Get the current register value.
^1da177e4c3f41 Linus Torvalds      2005-04-16   92  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16   93  	prb_offset = IIO_IOPRB(prbnum);
^1da177e4c3f41 Linus Torvalds      2005-04-16   94  	prb.iprb_regval = REMOTE_HUB_L(nasid, prb_offset);
^1da177e4c3f41 Linus Torvalds      2005-04-16   95  
^1da177e4c3f41 Linus Torvalds      2005-04-16   96  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16   97  	 * Clear out some fields.
^1da177e4c3f41 Linus Torvalds      2005-04-16   98  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16   99  	prb.iprb_ovflow = 1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  100  	prb.iprb_bnakctr = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  101  	prb.iprb_anakctr = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  102  
^1da177e4c3f41 Linus Torvalds      2005-04-16  103  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  104  	 * Enable or disable fire-and-forget mode.
^1da177e4c3f41 Linus Torvalds      2005-04-16  105  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  106  	prb.iprb_ff = force_fire_and_forget ? 1 : 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  107  
^1da177e4c3f41 Linus Torvalds      2005-04-16  108  	/*
87fd4e2692a2ad Andrea Gelmini      2016-05-21  109  	 * Set the appropriate number of PIO credits for the widget.
^1da177e4c3f41 Linus Torvalds      2005-04-16  110  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  111  	prb.iprb_xtalkctr = credits;
^1da177e4c3f41 Linus Torvalds      2005-04-16  112  
^1da177e4c3f41 Linus Torvalds      2005-04-16  113  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  114  	 * Store the new value to the register.
^1da177e4c3f41 Linus Torvalds      2005-04-16  115  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  116  	REMOTE_HUB_S(nasid, prb_offset, prb.iprb_regval);
^1da177e4c3f41 Linus Torvalds      2005-04-16  117  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  118  
^1da177e4c3f41 Linus Torvalds      2005-04-16  119  /**
^1da177e4c3f41 Linus Torvalds      2005-04-16  120   * hub_set_piomode  -  set pio mode for a given hub
^1da177e4c3f41 Linus Torvalds      2005-04-16  121   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  122   * @nasid:	physical node ID for the hub in question
^1da177e4c3f41 Linus Torvalds      2005-04-16  123   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  124   * Put the hub into either "PIO conveyor belt" mode or "fire-and-forget" mode.
^1da177e4c3f41 Linus Torvalds      2005-04-16  125   * To do this, we have to make absolutely sure that no PIOs are in progress
^1da177e4c3f41 Linus Torvalds      2005-04-16  126   * so we turn off access to all widgets for the duration of the function.
^1da177e4c3f41 Linus Torvalds      2005-04-16  127   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  128   * XXX - This code should really check what kind of widget we're talking
^1da177e4c3f41 Linus Torvalds      2005-04-16  129   * to.	Bridges can only handle three requests, but XG will do more.
^1da177e4c3f41 Linus Torvalds      2005-04-16  130   * How many can crossbow handle to widget 0?  We're assuming 1.
^1da177e4c3f41 Linus Torvalds      2005-04-16  131   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  132   * XXX - There is a bug in the crossbow that link reset PIOs do not
^1da177e4c3f41 Linus Torvalds      2005-04-16  133   * return write responses.  The easiest solution to this problem is to
^1da177e4c3f41 Linus Torvalds      2005-04-16  134   * leave widget 0 (xbow) in fire-and-forget mode at all times.	This
^1da177e4c3f41 Linus Torvalds      2005-04-16  135   * only affects pio's to xbow registers, which should be rare.
^1da177e4c3f41 Linus Torvalds      2005-04-16  136   **/
^1da177e4c3f41 Linus Torvalds      2005-04-16  137  static void hub_set_piomode(nasid_t nasid)
^1da177e4c3f41 Linus Torvalds      2005-04-16  138  {
db0e7d4e42b055 Thomas Bogendoerfer 2019-02-19  139  	u64 ii_iowa;
^1da177e4c3f41 Linus Torvalds      2005-04-16  140  	hubii_wcr_t ii_wcr;
^1da177e4c3f41 Linus Torvalds      2005-04-16  141  	unsigned i;
^1da177e4c3f41 Linus Torvalds      2005-04-16  142  
^1da177e4c3f41 Linus Torvalds      2005-04-16  143  	ii_iowa = REMOTE_HUB_L(nasid, IIO_OUTWIDGET_ACCESS);
^1da177e4c3f41 Linus Torvalds      2005-04-16  144  	REMOTE_HUB_S(nasid, IIO_OUTWIDGET_ACCESS, 0);
^1da177e4c3f41 Linus Torvalds      2005-04-16  145  
^1da177e4c3f41 Linus Torvalds      2005-04-16  146  	ii_wcr.wcr_reg_value = REMOTE_HUB_L(nasid, IIO_WCR);
^1da177e4c3f41 Linus Torvalds      2005-04-16  147  
^1da177e4c3f41 Linus Torvalds      2005-04-16  148  	if (ii_wcr.iwcr_dir_con) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  149  		/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  150  		 * Assume a bridge here.
^1da177e4c3f41 Linus Torvalds      2005-04-16  151  		 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  152  		hub_setup_prb(nasid, 0, 3);
^1da177e4c3f41 Linus Torvalds      2005-04-16  153  	} else {
^1da177e4c3f41 Linus Torvalds      2005-04-16  154  		/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  155  		 * Assume a crossbow here.
^1da177e4c3f41 Linus Torvalds      2005-04-16  156  		 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  157  		hub_setup_prb(nasid, 0, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  158  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  159  
^1da177e4c3f41 Linus Torvalds      2005-04-16  160  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  161  	 * XXX - Here's where we should take the widget type into
^1da177e4c3f41 Linus Torvalds      2005-04-16  162  	 * when account assigning credits.
^1da177e4c3f41 Linus Torvalds      2005-04-16  163  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  164  	for (i = HUB_WIDGET_ID_MIN; i <= HUB_WIDGET_ID_MAX; i++)
^1da177e4c3f41 Linus Torvalds      2005-04-16  165  		hub_setup_prb(nasid, i, 3);
^1da177e4c3f41 Linus Torvalds      2005-04-16  166  
^1da177e4c3f41 Linus Torvalds      2005-04-16  167  	REMOTE_HUB_S(nasid, IIO_OUTWIDGET_ACCESS, ii_iowa);
^1da177e4c3f41 Linus Torvalds      2005-04-16  168  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  169  
^1da177e4c3f41 Linus Torvalds      2005-04-16  170  /*
603e82edf78ad6 Joe Perches         2008-02-03  171   * hub_pio_init	 -  PIO-related hub initialization
^1da177e4c3f41 Linus Torvalds      2005-04-16  172   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  173   * @hub:	hubinfo structure for our hub
^1da177e4c3f41 Linus Torvalds      2005-04-16  174   */
4bf841ebf17aaa Thomas Bogendoerfer 2019-10-03 @175  void hub_pio_init(nasid_t nasid)

:::::: The code at line 30 was first introduced by commit
:::::: 4bf841ebf17aaa0f7712623896c699b44fa92f44 MIPS: SGI-IP27: get rid of compact node ids

:::::: TO: Thomas Bogendoerfer <tbogendoerfer@suse.de>
:::::: CC: Paul Burton <paul.burton@mips.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
TA8BAA==

--PNTmBPCT7hxwcZjr--
