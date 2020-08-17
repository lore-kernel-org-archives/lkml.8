Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F66C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03AE2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHQUwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:52:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:30326 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHQUwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:52:46 -0400
IronPort-SDR: yerhEVTOBZvGOj6UU+DGMAaz+pz0YpJqTCZK48T3gyeNO3O6sEo6GrVeExUXatKn5v5dsYnTfT
 IaIJu21YI/3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152194218"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="gz'50?scan'50,208,50";a="152194218"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 13:25:43 -0700
IronPort-SDR: jzCVYfmnnCLWFdUBaTPFv4KGSBVBFpxJkJzXLnl6vWWRom4/srMfKfFH8MtYDu50elFdzhpfIP
 BDVf4LWbyhKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="gz'50?scan'50,208,50";a="292544238"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2020 13:25:41 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7lhM-0000no-MM; Mon, 17 Aug 2020 20:25:40 +0000
Date:   Tue, 18 Aug 2020 04:25:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>
Subject: arch/mips/sgi-ip27/ip27-hubio.c:30:15: warning: no previous
 prototype for 'hub_pio_map'
Message-ID: <202008180419.YvRaQpHL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
commit: b78e9d63a3b6307b6b786e6ba189d3978b60ceb5 MIPS: SGI-IP27: use asm/sn/agent.h for including HUB related stuff
date:   7 months ago
config: mips-randconfig-r023-20200817 (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b78e9d63a3b6307b6b786e6ba189d3978b60ceb5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/sgi-ip27/ip27-hubio.c:30:15: warning: no previous prototype for 'hub_pio_map' [-Wmissing-prototypes]
      30 | unsigned long hub_pio_map(nasid_t nasid, xwidgetnum_t widget,
         |               ^~~~~~~~~~~
>> arch/mips/sgi-ip27/ip27-hubio.c:175:6: warning: no previous prototype for 'hub_pio_init' [-Wmissing-prototypes]
     175 | void hub_pio_init(nasid_t nasid)
         |      ^~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:130: Error: found '(', expected: ')'
   {standard input}:130: Error: found '(', expected: ')'
   {standard input}:130: Error: non-constant expression in ".if" statement
   {standard input}:130: Error: junk at end of line, first unrecognized character is `('
   {standard input}:155: Error: found '(', expected: ')'
   {standard input}:155: Error: found '(', expected: ')'
   {standard input}:155: Error: non-constant expression in ".if" statement
   {standard input}:155: Error: junk at end of line, first unrecognized character is `('
   {standard input}:641: Error: found '(', expected: ')'
   {standard input}:641: Error: found '(', expected: ')'
   {standard input}:641: Error: non-constant expression in ".if" statement
   {standard input}:641: Error: junk at end of line, first unrecognized character is `('

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b78e9d63a3b6307b6b786e6ba189d3978b60ceb5
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout b78e9d63a3b6307b6b786e6ba189d3978b60ceb5
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

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qgpaaAEA

--9amGYk9869ThD9tj--
