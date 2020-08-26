Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E57C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C9F20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgHZNAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:00:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:3675 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgHZM7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:59:55 -0400
IronPort-SDR: G8Du72tfL2gjycQLj1eq2/xULfNFikBskmVGUAuXhzjtaLI7Kupu/F8vhkwKmv14LZt2QfNe7d
 0XRCSUZEhOdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="143944615"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="gz'50?scan'50,208,50";a="143944615"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 05:42:38 -0700
IronPort-SDR: p++/qV9Xd9yYdf+FAOA472XQRwDVteRfe27ssjkAOwvGjg6rHAoly8ePepqaCzTl6NsuRnU4ih
 U9axSEbcXPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="gz'50?scan'50,208,50";a="329212906"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 05:42:33 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAul7-0001Ql-8y; Wed, 26 Aug 2020 12:42:33 +0000
Date:   Wed, 26 Aug 2020 20:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: [PATCH 09/14 v1] usb: typec: tcpm: Add support for Sink Fast
 Role SWAP(FRS)
Message-ID: <202008262012.oHFFi1iu%lkp@intel.com>
References: <20200825042210.300632-10-badhri@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825042210.300632-10-badhri@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Badhri,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next v5.9-rc2 next-20200826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Badhri-Jagan-Sridharan/TCPM-support-for-FRS-and-AutoDischarge-Disconnect/20200825-122527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: arm-randconfig-r005-20200826 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/typec/tcpm/tcpm.c: In function 'run_state_machine':
>> drivers/usb/typec/tcpm/tcpm.c:3684:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
    3684 |   tcpm_swap_complete(port, port->swap_status);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/typec/tcpm/tcpm.c:3685:2: note: here
    3685 |  case FR_SWAP_CANCEL:
         |  ^~~~
   At top level:
   drivers/usb/typec/tcpm/tcpm.c:1618:39: warning: 'tcpm_altmode_ops' defined but not used [-Wunused-const-variable=]
    1618 | static const struct typec_altmode_ops tcpm_altmode_ops = {
         |                                       ^~~~~~~~~~~~~~~~

# https://github.com/0day-ci/linux/commit/a8727cbd1e6baa15662e368128ac96b196fe540f
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Badhri-Jagan-Sridharan/TCPM-support-for-FRS-and-AutoDischarge-Disconnect/20200825-122527
git checkout a8727cbd1e6baa15662e368128ac96b196fe540f
vim +3684 drivers/usb/typec/tcpm/tcpm.c

fce042f02ef03c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-15  2982  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2983  static void run_state_machine(struct tcpm_port *port)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2984  {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2985  	int ret;
fce042f02ef03c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-15  2986  	enum typec_pwr_opmode opmode;
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  2987  	unsigned int msecs;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2988  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2989  	port->enter_state = port->state;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2990  	switch (port->state) {
7893f9e1c26d1f drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-04-16  2991  	case TOGGLING:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2992  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2993  	/* SRC states */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2994  	case SRC_UNATTACHED:
b17dd57118fee7 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  2995  		if (!port->non_pd_role_swap)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2996  			tcpm_swap_complete(port, -ENOTCONN);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  2997  		tcpm_src_detach(port);
7893f9e1c26d1f drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-04-16  2998  		if (tcpm_start_toggling(port, tcpm_rp_cc(port))) {
7893f9e1c26d1f drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-04-16  2999  			tcpm_set_state(port, TOGGLING, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3000  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3001  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3002  		tcpm_set_cc(port, tcpm_rp_cc(port));
9b0ae69909c281 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3003  		if (port->port_type == TYPEC_PORT_DRP)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3004  			tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3005  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3006  	case SRC_ATTACH_WAIT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3007  		if (tcpm_port_is_debug(port))
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3008  			tcpm_set_state(port, DEBUG_ACC_ATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3009  				       PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3010  		else if (tcpm_port_is_audio(port))
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3011  			tcpm_set_state(port, AUDIO_ACC_ATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3012  				       PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3013  		else if (tcpm_port_is_source(port))
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3014  			tcpm_set_state(port,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3015  				       tcpm_try_snk(port) ? SNK_TRY
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3016  							  : SRC_ATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3017  				       PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3018  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3019  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3020  	case SNK_TRY:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3021  		port->try_snk_count++;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3022  		/*
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3023  		 * Requirements:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3024  		 * - Do not drive vconn or vbus
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3025  		 * - Terminate CC pins (both) to Rd
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3026  		 * Action:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3027  		 * - Wait for tDRPTry (PD_T_DRP_TRY).
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3028  		 *   Until then, ignore any state changes.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3029  		 */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3030  		tcpm_set_cc(port, TYPEC_CC_RD);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3031  		tcpm_set_state(port, SNK_TRY_WAIT, PD_T_DRP_TRY);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3032  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3033  	case SNK_TRY_WAIT:
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3034  		if (tcpm_port_is_sink(port)) {
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3035  			tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE, 0);
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3036  		} else {
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3037  			tcpm_set_state(port, SRC_TRYWAIT, 0);
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3038  			port->max_wait = 0;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3039  		}
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3040  		break;
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3041  	case SNK_TRY_WAIT_DEBOUNCE:
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3042  		tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3043  			       PD_T_PD_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3044  		break;
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3045  	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3046  		if (port->vbus_present && tcpm_port_is_sink(port)) {
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3047  			tcpm_set_state(port, SNK_ATTACHED, 0);
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3048  		} else {
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3049  			tcpm_set_state(port, SRC_TRYWAIT, 0);
a0a3e04e6b2c7c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3050  			port->max_wait = 0;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3051  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3052  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3053  	case SRC_TRYWAIT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3054  		tcpm_set_cc(port, tcpm_rp_cc(port));
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3055  		if (port->max_wait == 0) {
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3056  			port->max_wait = jiffies +
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3057  					 msecs_to_jiffies(PD_T_DRP_TRY);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3058  			tcpm_set_state(port, SRC_TRYWAIT_UNATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3059  				       PD_T_DRP_TRY);
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3060  		} else {
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3061  			if (time_is_after_jiffies(port->max_wait))
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3062  				tcpm_set_state(port, SRC_TRYWAIT_UNATTACHED,
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3063  					       jiffies_to_msecs(port->max_wait -
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3064  								jiffies));
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3065  			else
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3066  				tcpm_set_state(port, SNK_UNATTACHED, 0);
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3067  		}
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3068  		break;
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3069  	case SRC_TRYWAIT_DEBOUNCE:
02d5be466b68f6 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3070  		tcpm_set_state(port, SRC_ATTACHED, PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3071  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3072  	case SRC_TRYWAIT_UNATTACHED:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3073  		tcpm_set_state(port, SNK_UNATTACHED, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3074  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3075  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3076  	case SRC_ATTACHED:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3077  		ret = tcpm_src_attach(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3078  		tcpm_set_state(port, SRC_UNATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3079  			       ret < 0 ? 0 : PD_T_PS_SOURCE_ON);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3080  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3081  	case SRC_STARTUP:
fce042f02ef03c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-15  3082  		opmode =  tcpm_get_pwr_opmode(tcpm_rp_cc(port));
fce042f02ef03c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-15  3083  		typec_set_pwr_opmode(port->typec_port, opmode);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3084  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3085  		port->caps_count = 0;
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3086  		port->negotiated_rev = PD_MAX_REV;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3087  		port->message_id = 0;
5fec4b54d0bf6c drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3088  		port->rx_msgid = -1;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3089  		port->explicit_contract = false;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3090  		tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3091  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3092  	case SRC_SEND_CAPABILITIES:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3093  		port->caps_count++;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3094  		if (port->caps_count > PD_N_CAPS_COUNT) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3095  			tcpm_set_state(port, SRC_READY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3096  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3097  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3098  		ret = tcpm_pd_send_source_caps(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3099  		if (ret < 0) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3100  			tcpm_set_state(port, SRC_SEND_CAPABILITIES,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3101  				       PD_T_SEND_SOURCE_CAP);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3102  		} else {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3103  			/*
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3104  			 * Per standard, we should clear the reset counter here.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3105  			 * However, that can result in state machine hang-ups.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3106  			 * Reset it only in READY state to improve stability.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3107  			 */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3108  			/* port->hard_reset_count = 0; */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3109  			port->caps_count = 0;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3110  			port->pd_capable = true;
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3111  			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3112  					    PD_T_SEND_SOURCE_CAP);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3113  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3114  		break;
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3115  	case SRC_SEND_CAPABILITIES_TIMEOUT:
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3116  		/*
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3117  		 * Error recovery for a PD_DATA_SOURCE_CAP reply timeout.
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3118  		 *
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3119  		 * PD 2.0 sinks are supposed to accept src-capabilities with a
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3120  		 * 3.0 header and simply ignore any src PDOs which the sink does
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3121  		 * not understand such as PPS but some 2.0 sinks instead ignore
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3122  		 * the entire PD_DATA_SOURCE_CAP message, causing contract
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3123  		 * negotiation to fail.
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3124  		 *
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3125  		 * After PD_N_HARD_RESET_COUNT hard-reset attempts, we try
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3126  		 * sending src-capabilities with a lower PD revision to
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3127  		 * make these broken sinks work.
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3128  		 */
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3129  		if (port->hard_reset_count < PD_N_HARD_RESET_COUNT) {
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3130  			tcpm_set_state(port, HARD_RESET_SEND, 0);
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3131  		} else if (port->negotiated_rev > PD_REV20) {
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3132  			port->negotiated_rev--;
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3133  			port->hard_reset_count = 0;
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3134  			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3135  		} else {
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3136  			tcpm_set_state(port, hard_reset_state(port), 0);
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3137  		}
976daf9d119993 drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-03-16  3138  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3139  	case SRC_NEGOTIATE_CAPABILITIES:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3140  		ret = tcpm_pd_check_request(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3141  		if (ret < 0) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3142  			tcpm_pd_send_control(port, PD_CTRL_REJECT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3143  			if (!port->explicit_contract) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3144  				tcpm_set_state(port,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3145  					       SRC_WAIT_NEW_CAPABILITIES, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3146  			} else {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3147  				tcpm_set_state(port, SRC_READY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3148  			}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3149  		} else {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3150  			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3151  			tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3152  				       PD_T_SRC_TRANSITION);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3153  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3154  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3155  	case SRC_TRANSITION_SUPPLY:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3156  		/* XXX: regulator_set_voltage(vbus, ...) */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3157  		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3158  		port->explicit_contract = true;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3159  		typec_set_pwr_opmode(port->typec_port, TYPEC_PWR_MODE_PD);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3160  		port->pwr_opmode = TYPEC_PWR_MODE_PD;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3161  		tcpm_set_state_cond(port, SRC_READY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3162  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3163  	case SRC_READY:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3164  #if 1
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3165  		port->hard_reset_count = 0;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3166  #endif
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3167  		port->try_src_count = 0;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3168  
3113bf1a5da35f drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3169  		tcpm_swap_complete(port, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3170  		tcpm_typec_connect(port);
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3171  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3172  		tcpm_check_send_discover(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3173  		/*
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3174  		 * 6.3.5
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3175  		 * Sending ping messages is not necessary if
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3176  		 * - the source operates at vSafe5V
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3177  		 * or
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3178  		 * - The system is not operating in PD mode
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3179  		 * or
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3180  		 * - Both partners are connected using a Type-C connector
f451ac9e4c6dd2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3181  		 *
f451ac9e4c6dd2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3182  		 * There is no actual need to send PD messages since the local
f451ac9e4c6dd2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3183  		 * port type-c and the spec does not clearly say whether PD is
f451ac9e4c6dd2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3184  		 * possible when type-c is connected to Type-A/B
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3185  		 */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3186  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3187  	case SRC_WAIT_NEW_CAPABILITIES:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3188  		/* Nothing to do... */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3189  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3190  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3191  	/* SNK states */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3192  	case SNK_UNATTACHED:
b17dd57118fee7 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3193  		if (!port->non_pd_role_swap)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3194  			tcpm_swap_complete(port, -ENOTCONN);
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3195  		tcpm_pps_complete(port, -ENOTCONN);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3196  		tcpm_snk_detach(port);
7893f9e1c26d1f drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-04-16  3197  		if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
7893f9e1c26d1f drivers/usb/typec/tcpm/tcpm.c Hans de Goede          2019-04-16  3198  			tcpm_set_state(port, TOGGLING, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3199  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3200  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3201  		tcpm_set_cc(port, TYPEC_CC_RD);
9b0ae69909c281 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3202  		if (port->port_type == TYPEC_PORT_DRP)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3203  			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3204  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3205  	case SNK_ATTACH_WAIT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3206  		if ((port->cc1 == TYPEC_CC_OPEN &&
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3207  		     port->cc2 != TYPEC_CC_OPEN) ||
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3208  		    (port->cc1 != TYPEC_CC_OPEN &&
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3209  		     port->cc2 == TYPEC_CC_OPEN))
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3210  			tcpm_set_state(port, SNK_DEBOUNCED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3211  				       PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3212  		else if (tcpm_port_is_disconnected(port))
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3213  			tcpm_set_state(port, SNK_UNATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3214  				       PD_T_PD_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3215  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3216  	case SNK_DEBOUNCED:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3217  		if (tcpm_port_is_disconnected(port))
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3218  			tcpm_set_state(port, SNK_UNATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3219  				       PD_T_PD_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3220  		else if (port->vbus_present)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3221  			tcpm_set_state(port,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3222  				       tcpm_try_src(port) ? SRC_TRY
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3223  							  : SNK_ATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3224  				       0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3225  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3226  			/* Wait for VBUS, but not forever */
56277035c294ec drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3227  			tcpm_set_state(port, PORT_RESET, PD_T_PS_SOURCE_ON);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3228  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3229  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3230  	case SRC_TRY:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3231  		port->try_src_count++;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3232  		tcpm_set_cc(port, tcpm_rp_cc(port));
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3233  		port->max_wait = 0;
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3234  		tcpm_set_state(port, SRC_TRY_WAIT, 0);
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3235  		break;
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3236  	case SRC_TRY_WAIT:
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3237  		if (port->max_wait == 0) {
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3238  			port->max_wait = jiffies +
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3239  					 msecs_to_jiffies(PD_T_DRP_TRY);
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3240  			msecs = PD_T_DRP_TRY;
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3241  		} else {
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3242  			if (time_is_after_jiffies(port->max_wait))
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3243  				msecs = jiffies_to_msecs(port->max_wait -
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3244  							 jiffies);
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3245  			else
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3246  				msecs = 0;
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3247  		}
131c7d12ef21e1 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3248  		tcpm_set_state(port, SNK_TRYWAIT, msecs);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3249  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3250  	case SRC_TRY_DEBOUNCE:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3251  		tcpm_set_state(port, SRC_ATTACHED, PD_T_PD_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3252  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3253  	case SNK_TRYWAIT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3254  		tcpm_set_cc(port, TYPEC_CC_RD);
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3255  		tcpm_set_state(port, SNK_TRYWAIT_VBUS, PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3256  		break;
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3257  	case SNK_TRYWAIT_VBUS:
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3258  		/*
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3259  		 * TCPM stays in this state indefinitely until VBUS
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3260  		 * is detected as long as Rp is not detected for
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3261  		 * more than a time period of tPDDebounce.
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3262  		 */
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3263  		if (port->vbus_present && tcpm_port_is_sink(port)) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3264  			tcpm_set_state(port, SNK_ATTACHED, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3265  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3266  		}
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3267  		if (!tcpm_port_is_sink(port))
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3268  			tcpm_set_state(port, SNK_TRYWAIT_DEBOUNCE, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3269  		break;
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3270  	case SNK_TRYWAIT_DEBOUNCE:
af450ebb500ad2 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3271  		tcpm_set_state(port, SNK_UNATTACHED, PD_T_PD_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3272  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3273  	case SNK_ATTACHED:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3274  		ret = tcpm_snk_attach(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3275  		if (ret < 0)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3276  			tcpm_set_state(port, SNK_UNATTACHED, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3277  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3278  			tcpm_set_state(port, SNK_STARTUP, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3279  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3280  	case SNK_STARTUP:
fce042f02ef03c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-15  3281  		opmode =  tcpm_get_pwr_opmode(port->polarity ?
fce042f02ef03c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-15  3282  					      port->cc2 : port->cc1);
fce042f02ef03c drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-15  3283  		typec_set_pwr_opmode(port->typec_port, opmode);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3284  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3285  		port->negotiated_rev = PD_MAX_REV;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3286  		port->message_id = 0;
5fec4b54d0bf6c drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3287  		port->rx_msgid = -1;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3288  		port->explicit_contract = false;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3289  		tcpm_set_state(port, SNK_DISCOVERY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3290  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3291  	case SNK_DISCOVERY:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3292  		if (port->vbus_present) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3293  			tcpm_set_current_limit(port,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3294  					       tcpm_get_current_limit(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3295  					       5000);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3296  			tcpm_set_charge(port, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3297  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3298  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3299  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3300  		/*
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3301  		 * For DRP, timeouts differ. Also, handling is supposed to be
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3302  		 * different and much more complex (dead battery detection;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3303  		 * see USB power delivery specification, section 8.3.3.6.1.5.1).
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3304  		 */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3305  		tcpm_set_state(port, hard_reset_state(port),
9b0ae69909c281 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3306  			       port->port_type == TYPEC_PORT_DRP ?
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3307  					PD_T_DB_DETECT : PD_T_NO_RESPONSE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3308  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3309  	case SNK_DISCOVERY_DEBOUNCE:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3310  		tcpm_set_state(port, SNK_DISCOVERY_DEBOUNCE_DONE,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3311  			       PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3312  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3313  	case SNK_DISCOVERY_DEBOUNCE_DONE:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3314  		if (!tcpm_port_is_disconnected(port) &&
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3315  		    tcpm_port_is_sink(port) &&
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3316  		    time_is_after_jiffies(port->delayed_runtime)) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3317  			tcpm_set_state(port, SNK_DISCOVERY,
9578bcd0bb487b drivers/usb/typec/tcpm.c      Dan Carpenter          2018-06-07  3318  				       jiffies_to_msecs(port->delayed_runtime -
9578bcd0bb487b drivers/usb/typec/tcpm.c      Dan Carpenter          2018-06-07  3319  							jiffies));
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3320  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3321  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3322  		tcpm_set_state(port, unattached_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3323  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3324  	case SNK_WAIT_CAPABILITIES:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3325  		ret = port->tcpc->set_pd_rx(port->tcpc, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3326  		if (ret < 0) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3327  			tcpm_set_state(port, SNK_READY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3328  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3329  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3330  		/*
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3331  		 * If VBUS has never been low, and we time out waiting
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3332  		 * for source cap, try a soft reset first, in case we
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3333  		 * were already in a stable contract before this boot.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3334  		 * Do this only once.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3335  		 */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3336  		if (port->vbus_never_low) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3337  			port->vbus_never_low = false;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3338  			tcpm_set_state(port, SOFT_RESET_SEND,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3339  				       PD_T_SINK_WAIT_CAP);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3340  		} else {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3341  			tcpm_set_state(port, hard_reset_state(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3342  				       PD_T_SINK_WAIT_CAP);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3343  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3344  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3345  	case SNK_NEGOTIATE_CAPABILITIES:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3346  		port->pd_capable = true;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3347  		port->hard_reset_count = 0;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3348  		ret = tcpm_pd_send_request(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3349  		if (ret < 0) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3350  			/* Let the Source send capabilities again. */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3351  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3352  		} else {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3353  			tcpm_set_state_cond(port, hard_reset_state(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3354  					    PD_T_SENDER_RESPONSE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3355  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3356  		break;
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3357  	case SNK_NEGOTIATE_PPS_CAPABILITIES:
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3358  		ret = tcpm_pd_send_pps_request(port);
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3359  		if (ret < 0) {
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3360  			port->pps_status = ret;
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3361  			/*
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3362  			 * If this was called due to updates to sink
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3363  			 * capabilities, and pps is no longer valid, we should
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3364  			 * safely fall back to a standard PDO.
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3365  			 */
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3366  			if (port->update_sink_caps)
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3367  				tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3368  			else
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3369  				tcpm_set_state(port, SNK_READY, 0);
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3370  		} else {
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3371  			tcpm_set_state_cond(port, hard_reset_state(port),
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3372  					    PD_T_SENDER_RESPONSE);
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3373  		}
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3374  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3375  	case SNK_TRANSITION_SINK:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3376  	case SNK_TRANSITION_SINK_VBUS:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3377  		tcpm_set_state(port, hard_reset_state(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3378  			       PD_T_PS_TRANSITION);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3379  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3380  	case SNK_READY:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3381  		port->try_snk_count = 0;
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3382  		port->update_sink_caps = false;
8bf05746cffa34 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-17  3383  		if (port->explicit_contract) {
8bf05746cffa34 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-17  3384  			typec_set_pwr_opmode(port->typec_port,
8bf05746cffa34 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-17  3385  					     TYPEC_PWR_MODE_PD);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3386  			port->pwr_opmode = TYPEC_PWR_MODE_PD;
8bf05746cffa34 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-17  3387  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3388  
3113bf1a5da35f drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3389  		tcpm_swap_complete(port, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3390  		tcpm_typec_connect(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3391  		tcpm_check_send_discover(port);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3392  		mod_delayed_work(port->wq, &port->enable_frs, msecs_to_jiffies(0));
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3393  		tcpm_pps_complete(port, port->pps_status);
f2a8aa053c1761 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3394  		power_supply_changed(port->psy);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3395  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3396  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3397  	/* Accessory states */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3398  	case ACC_UNATTACHED:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3399  		tcpm_acc_detach(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3400  		tcpm_set_state(port, SRC_UNATTACHED, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3401  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3402  	case DEBUG_ACC_ATTACHED:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3403  	case AUDIO_ACC_ATTACHED:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3404  		ret = tcpm_acc_attach(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3405  		if (ret < 0)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3406  			tcpm_set_state(port, ACC_UNATTACHED, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3407  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3408  	case AUDIO_ACC_DEBOUNCE:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3409  		tcpm_set_state(port, ACC_UNATTACHED, PD_T_CC_DEBOUNCE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3410  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3411  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3412  	/* Hard_Reset states */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3413  	case HARD_RESET_SEND:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3414  		tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3415  		tcpm_set_state(port, HARD_RESET_START, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3416  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3417  	case HARD_RESET_START:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3418  		port->sink_cap_done = false;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3419  		if (port->tcpc->enable_frs)
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3420  			port->tcpc->enable_frs(port->tcpc, false);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3421  		port->hard_reset_count++;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3422  		port->tcpc->set_pd_rx(port->tcpc, false);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3423  		tcpm_unregister_altmodes(port);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3424  		port->nr_sink_caps = 0;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3425  		port->send_discover = true;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3426  		if (port->pwr_role == TYPEC_SOURCE)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3427  			tcpm_set_state(port, SRC_HARD_RESET_VBUS_OFF,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3428  				       PD_T_PS_HARD_RESET);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3429  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3430  			tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3431  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3432  	case SRC_HARD_RESET_VBUS_OFF:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3433  		tcpm_set_vconn(port, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3434  		tcpm_set_vbus(port, false);
23b5f73266e59a drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3435  		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
6ecc632d4b35d2 drivers/usb/typec/tcpm/tcpm.c Li Jun                 2020-02-14  3436  			       tcpm_data_role_for_source(port));
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3437  		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3438  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3439  	case SRC_HARD_RESET_VBUS_ON:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3440  		tcpm_set_vbus(port, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3441  		port->tcpc->set_pd_rx(port->tcpc, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3442  		tcpm_set_attached_state(port, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3443  		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3444  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3445  	case SNK_HARD_RESET_SINK_OFF:
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3446  		memset(&port->pps_data, 0, sizeof(port->pps_data));
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3447  		tcpm_set_vconn(port, false);
157c0f2f641a99 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3448  		if (port->pd_capable)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3449  			tcpm_set_charge(port, false);
23b5f73266e59a drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3450  		tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
6ecc632d4b35d2 drivers/usb/typec/tcpm/tcpm.c Li Jun                 2020-02-14  3451  			       tcpm_data_role_for_sink(port));
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3452  		/*
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3453  		 * VBUS may or may not toggle, depending on the adapter.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3454  		 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3455  		 * directly after timeout.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3456  		 */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3457  		tcpm_set_state(port, SNK_HARD_RESET_SINK_ON, PD_T_SAFE_0V);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3458  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3459  	case SNK_HARD_RESET_WAIT_VBUS:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3460  		/* Assume we're disconnected if VBUS doesn't come back. */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3461  		tcpm_set_state(port, SNK_UNATTACHED,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3462  			       PD_T_SRC_RECOVER_MAX + PD_T_SRC_TURN_ON);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3463  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3464  	case SNK_HARD_RESET_SINK_ON:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3465  		/* Note: There is no guarantee that VBUS is on in this state */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3466  		/*
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3467  		 * XXX:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3468  		 * The specification suggests that dual mode ports in sink
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3469  		 * mode should transition to state PE_SRC_Transition_to_default.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3470  		 * See USB power delivery specification chapter 8.3.3.6.1.3.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3471  		 * This would mean to to
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3472  		 * - turn off VCONN, reset power supply
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3473  		 * - request hardware reset
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3474  		 * - turn on VCONN
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3475  		 * - Transition to state PE_Src_Startup
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3476  		 * SNK only ports shall transition to state Snk_Startup
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3477  		 * (see chapter 8.3.3.3.8).
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3478  		 * Similar, dual-mode ports in source mode should transition
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3479  		 * to PE_SNK_Transition_to_default.
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3480  		 */
157c0f2f641a99 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3481  		if (port->pd_capable) {
157c0f2f641a99 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3482  			tcpm_set_current_limit(port,
157c0f2f641a99 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3483  					       tcpm_get_current_limit(port),
157c0f2f641a99 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3484  					       5000);
157c0f2f641a99 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3485  			tcpm_set_charge(port, true);
157c0f2f641a99 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2018-10-01  3486  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3487  		tcpm_set_attached_state(port, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3488  		tcpm_set_state(port, SNK_STARTUP, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3489  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3490  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3491  	/* Soft_Reset states */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3492  	case SOFT_RESET:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3493  		port->message_id = 0;
5fec4b54d0bf6c drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3494  		port->rx_msgid = -1;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3495  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3496  		if (port->pwr_role == TYPEC_SOURCE)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3497  			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3498  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3499  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3500  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3501  	case SOFT_RESET_SEND:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3502  		port->message_id = 0;
5fec4b54d0bf6c drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3503  		port->rx_msgid = -1;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3504  		if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET))
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3505  			tcpm_set_state_cond(port, hard_reset_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3506  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3507  			tcpm_set_state_cond(port, hard_reset_state(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3508  					    PD_T_SENDER_RESPONSE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3509  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3510  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3511  	/* DR_Swap states */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3512  	case DR_SWAP_SEND:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3513  		tcpm_pd_send_control(port, PD_CTRL_DR_SWAP);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3514  		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3515  				    PD_T_SENDER_RESPONSE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3516  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3517  	case DR_SWAP_ACCEPT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3518  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3519  		tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3520  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3521  	case DR_SWAP_SEND_TIMEOUT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3522  		tcpm_swap_complete(port, -ETIMEDOUT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3523  		tcpm_set_state(port, ready_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3524  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3525  	case DR_SWAP_CHANGE_DR:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3526  		if (port->data_role == TYPEC_HOST) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3527  			tcpm_unregister_altmodes(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3528  			tcpm_set_roles(port, true, port->pwr_role,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3529  				       TYPEC_DEVICE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3530  		} else {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3531  			tcpm_set_roles(port, true, port->pwr_role,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3532  				       TYPEC_HOST);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3533  			port->send_discover = true;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3534  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3535  		tcpm_set_state(port, ready_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3536  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3537  
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3538  	case FR_SWAP_SEND:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3539  		if (tcpm_pd_send_control(port, PD_CTRL_FR_SWAP)) {
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3540  			tcpm_set_state(port, ERROR_RECOVERY, 0);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3541  			break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3542  		}
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3543  		tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, PD_T_SENDER_RESPONSE);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3544  		break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3545  	case FR_SWAP_SEND_TIMEOUT:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3546  		tcpm_set_state(port, ERROR_RECOVERY, 0);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3547  		break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3548  	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3549  		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_OFF);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3550  		break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3551  	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3552  		if (port->vbus_source)
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3553  			tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3554  		else
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3555  			tcpm_set_state(port, ERROR_RECOVERY, PD_T_RECEIVER_RESPONSE);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3556  		break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3557  	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3558  		tcpm_set_pwr_role(port, TYPEC_SOURCE);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3559  		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3560  			tcpm_set_state(port, ERROR_RECOVERY, 0);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3561  			break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3562  		}
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3563  		tcpm_set_cc(port, tcpm_rp_cc(port));
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3564  		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3565  		break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3566  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3567  	/* PR_Swap states */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3568  	case PR_SWAP_ACCEPT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3569  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3570  		tcpm_set_state(port, PR_SWAP_START, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3571  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3572  	case PR_SWAP_SEND:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3573  		tcpm_pd_send_control(port, PD_CTRL_PR_SWAP);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3574  		tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3575  				    PD_T_SENDER_RESPONSE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3576  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3577  	case PR_SWAP_SEND_TIMEOUT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3578  		tcpm_swap_complete(port, -ETIMEDOUT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3579  		tcpm_set_state(port, ready_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3580  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3581  	case PR_SWAP_START:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3582  		if (port->pwr_role == TYPEC_SOURCE)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3583  			tcpm_set_state(port, PR_SWAP_SRC_SNK_TRANSITION_OFF,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3584  				       PD_T_SRC_TRANSITION);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3585  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3586  			tcpm_set_state(port, PR_SWAP_SNK_SRC_SINK_OFF, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3587  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3588  	case PR_SWAP_SRC_SNK_TRANSITION_OFF:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3589  		tcpm_set_vbus(port, false);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3590  		port->explicit_contract = false;
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3591  		/* allow time for Vbus discharge, must be < tSrcSwapStdby */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3592  		tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF,
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3593  			       PD_T_SRCSWAPSTDBY);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3594  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3595  	case PR_SWAP_SRC_SNK_SOURCE_OFF:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3596  		tcpm_set_cc(port, TYPEC_CC_RD);
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3597  		/* allow CC debounce */
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3598  		tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED,
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3599  			       PD_T_CC_DEBOUNCE);
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3600  		break;
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3601  	case PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED:
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3602  		/*
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3603  		 * USB-PD standard, 6.2.1.4, Port Power Role:
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3604  		 * "During the Power Role Swap Sequence, for the initial Source
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3605  		 * Port, the Port Power Role field shall be set to Sink in the
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3606  		 * PS_RDY Message indicating that the initial Source’s power
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3607  		 * supply is turned off"
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3608  		 */
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3609  		tcpm_set_pwr_role(port, TYPEC_SINK);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3610  		if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3611  			tcpm_set_state(port, ERROR_RECOVERY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3612  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3613  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3614  		tcpm_set_state_cond(port, SNK_UNATTACHED, PD_T_PS_SOURCE_ON);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3615  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3616  	case PR_SWAP_SRC_SNK_SINK_ON:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3617  		tcpm_set_state(port, SNK_STARTUP, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3618  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3619  	case PR_SWAP_SNK_SRC_SINK_OFF:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3620  		tcpm_set_charge(port, false);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3621  		tcpm_set_state(port, hard_reset_state(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3622  			       PD_T_PS_SOURCE_OFF);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3623  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3624  	case PR_SWAP_SNK_SRC_SOURCE_ON:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3625  		tcpm_set_cc(port, tcpm_rp_cc(port));
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3626  		tcpm_set_vbus(port, true);
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3627  		/*
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3628  		 * allow time VBUS ramp-up, must be < tNewSrc
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3629  		 * Also, this window overlaps with CC debounce as well.
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3630  		 * So, Wait for the max of two which is PD_T_NEWSRC
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3631  		 */
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3632  		tcpm_set_state(port, PR_SWAP_SNK_SRC_SOURCE_ON_VBUS_RAMPED_UP,
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3633  			       PD_T_NEWSRC);
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3634  		break;
b965b6317ff147 drivers/staging/typec/tcpm.c  Badhri Jagan Sridharan 2017-08-28  3635  	case PR_SWAP_SNK_SRC_SOURCE_ON_VBUS_RAMPED_UP:
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3636  		/*
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3637  		 * USB PD standard, 6.2.1.4:
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3638  		 * "Subsequent Messages initiated by the Policy Engine,
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3639  		 * such as the PS_RDY Message sent to indicate that Vbus
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3640  		 * is ready, will have the Port Power Role field set to
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3641  		 * Source."
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3642  		 */
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3643  		tcpm_set_pwr_role(port, TYPEC_SOURCE);
050161ea3268ad drivers/staging/typec/tcpm.c  Guenter Roeck          2017-05-09  3644  		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3645  		tcpm_set_state(port, SRC_STARTUP, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3646  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3647  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3648  	case VCONN_SWAP_ACCEPT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3649  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3650  		tcpm_set_state(port, VCONN_SWAP_START, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3651  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3652  	case VCONN_SWAP_SEND:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3653  		tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3654  		tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3655  			       PD_T_SENDER_RESPONSE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3656  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3657  	case VCONN_SWAP_SEND_TIMEOUT:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3658  		tcpm_swap_complete(port, -ETIMEDOUT);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3659  		tcpm_set_state(port, ready_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3660  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3661  	case VCONN_SWAP_START:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3662  		if (port->vconn_role == TYPEC_SOURCE)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3663  			tcpm_set_state(port, VCONN_SWAP_WAIT_FOR_VCONN, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3664  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3665  			tcpm_set_state(port, VCONN_SWAP_TURN_ON_VCONN, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3666  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3667  	case VCONN_SWAP_WAIT_FOR_VCONN:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3668  		tcpm_set_state(port, hard_reset_state(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3669  			       PD_T_VCONN_SOURCE_ON);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3670  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3671  	case VCONN_SWAP_TURN_ON_VCONN:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3672  		tcpm_set_vconn(port, true);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3673  		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3674  		tcpm_set_state(port, ready_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3675  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3676  	case VCONN_SWAP_TURN_OFF_VCONN:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3677  		tcpm_set_vconn(port, false);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3678  		tcpm_set_state(port, ready_state(port), 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3679  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3680  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3681  	case DR_SWAP_CANCEL:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3682  	case PR_SWAP_CANCEL:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3683  	case VCONN_SWAP_CANCEL:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27 @3684  		tcpm_swap_complete(port, port->swap_status);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3685  	case FR_SWAP_CANCEL:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3686  		if (port->pwr_role == TYPEC_SOURCE)
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3687  			tcpm_set_state(port, SRC_READY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3688  		else
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3689  			tcpm_set_state(port, SNK_READY, 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3690  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3691  
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3692  	case BIST_RX:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3693  		switch (BDO_MODE_MASK(port->bist_request)) {
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3694  		case BDO_MODE_CARRIER2:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3695  			tcpm_pd_transmit(port, TCPC_TX_BIST_MODE_2, NULL);
6e1c2241f4cecf drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3696  			tcpm_set_state(port, unattached_state(port),
6e1c2241f4cecf drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3697  				       PD_T_BIST_CONT_MODE);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3698  			break;
b2dcfefc43f783 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3699  		case BDO_MODE_TESTDATA:
b2dcfefc43f783 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3700  			if (port->tcpc->set_bist_data) {
b2dcfefc43f783 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3701  				tcpm_log(port, "Enable BIST MODE TESTDATA");
b2dcfefc43f783 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3702  				port->tcpc->set_bist_data(port->tcpc, true);
b2dcfefc43f783 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3703  			}
b2dcfefc43f783 drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-07-15  3704  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3705  		default:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3706  			break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3707  		}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3708  		break;
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3709  	case GET_STATUS_SEND:
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3710  		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3711  		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3712  			       PD_T_SENDER_RESPONSE);
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3713  		break;
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3714  	case GET_STATUS_SEND_TIMEOUT:
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3715  		tcpm_set_state(port, ready_state(port), 0);
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3716  		break;
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3717  	case GET_PPS_STATUS_SEND:
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3718  		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3719  		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3720  			       PD_T_SENDER_RESPONSE);
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3721  		break;
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3722  	case GET_PPS_STATUS_SEND_TIMEOUT:
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3723  		tcpm_set_state(port, ready_state(port), 0);
64f7c494a3c02b drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3724  		break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3725  	case GET_SINK_CAP:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3726  		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3727  		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RESPONSE);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3728  		break;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3729  	case GET_SINK_CAP_TIMEOUT:
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3730  		port->sink_cap_done = true;
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3731  		tcpm_set_state(port, ready_state(port), 0);
a8727cbd1e6baa drivers/usb/typec/tcpm/tcpm.c Badhri Jagan Sridharan 2020-08-24  3732  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3733  	case ERROR_RECOVERY:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3734  		tcpm_swap_complete(port, -EPROTO);
2eadc33f40d4c5 drivers/usb/typec/tcpm.c      Adam Thomson           2018-04-23  3735  		tcpm_pps_complete(port, -EPROTO);
b17dd57118fee7 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3736  		tcpm_set_state(port, PORT_RESET, 0);
b17dd57118fee7 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3737  		break;
b17dd57118fee7 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3738  	case PORT_RESET:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3739  		tcpm_reset_port(port);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3740  		tcpm_set_cc(port, TYPEC_CC_OPEN);
b17dd57118fee7 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3741  		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3742  			       PD_T_ERROR_RECOVERY);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3743  		break;
b17dd57118fee7 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-08-10  3744  	case PORT_RESET_WAIT_OFF:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3745  		tcpm_set_state(port,
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3746  			       tcpm_default_state(port),
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3747  			       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3748  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3749  	default:
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3750  		WARN(1, "Unexpected port state %d\n", port->state);
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3751  		break;
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3752  	}
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3753  }
f0690a25a140b8 drivers/staging/typec/tcpm.c  Guenter Roeck          2017-04-27  3754  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--AhhlLboLdkugWU4S
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
rRQFKQLWAQA=

--AhhlLboLdkugWU4S--
