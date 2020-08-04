Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD893C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E3D206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgHDIbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:31:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:21107 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgHDIbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:31:43 -0400
IronPort-SDR: 9PhgcT6EV8jD+4q1l97OAqHalmpVJt7iMuyCqkwQZMMVtdlgRyXxwoLYGWHoSXZywLMe8LgCp4
 VDy1FqxduqXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="131841722"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="gz'50?scan'50,208,50";a="131841722"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 01:27:37 -0700
IronPort-SDR: DpfYvIjb4loMZM0lqURc/+PvUrMfqImQflaff5kfP932+3m7d7bykbrwSdkhXXqcAyL/I6kq3f
 pjM7mD0kcqtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="gz'50?scan'50,208,50";a="330531990"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 01:27:34 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2sII-00000h-Ch; Tue, 04 Aug 2020 08:27:34 +0000
Date:   Tue, 4 Aug 2020 16:26:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, --validate@google.com,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: [PATCH v1] tcpm: Honour pSnkStdby requirement during negotiation
Message-ID: <202008041617.iVubhWnE%lkp@intel.com>
References: <20200804065111.3889122-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804065111.3889122-1-badhri@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Badhri,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on next-20200803]
[cannot apply to v5.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Badhri-Jagan-Sridharan/tcpm-Honour-pSnkStdby-requirement-during-negotiation/20200804-145301
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: nios2-allyesconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/typec/tcpm/tcpm.c: In function 'run_state_machine':
>> drivers/usb/typec/tcpm/tcpm.c:3339:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
    3339 |   if (port->psnkstdby_after_accept)
         |      ^
   drivers/usb/typec/tcpm/tcpm.c:3343:2: note: here
    3343 |  case SNK_TRANSITION_SINK_VBUS:
         |  ^~~~
   At top level:
   drivers/usb/typec/tcpm/tcpm.c:1614:39: warning: 'tcpm_altmode_ops' defined but not used [-Wunused-const-variable=]
    1614 | static const struct typec_altmode_ops tcpm_altmode_ops = {
         |                                       ^~~~~~~~~~~~~~~~

vim +3339 drivers/usb/typec/tcpm/tcpm.c

  2943	
  2944	static void run_state_machine(struct tcpm_port *port)
  2945	{
  2946		int ret;
  2947		enum typec_pwr_opmode opmode;
  2948		unsigned int msecs;
  2949	
  2950		port->enter_state = port->state;
  2951		switch (port->state) {
  2952		case TOGGLING:
  2953			break;
  2954		/* SRC states */
  2955		case SRC_UNATTACHED:
  2956			if (!port->non_pd_role_swap)
  2957				tcpm_swap_complete(port, -ENOTCONN);
  2958			tcpm_src_detach(port);
  2959			if (tcpm_start_toggling(port, tcpm_rp_cc(port))) {
  2960				tcpm_set_state(port, TOGGLING, 0);
  2961				break;
  2962			}
  2963			tcpm_set_cc(port, tcpm_rp_cc(port));
  2964			if (port->port_type == TYPEC_PORT_DRP)
  2965				tcpm_set_state(port, SNK_UNATTACHED, PD_T_DRP_SNK);
  2966			break;
  2967		case SRC_ATTACH_WAIT:
  2968			if (tcpm_port_is_debug(port))
  2969				tcpm_set_state(port, DEBUG_ACC_ATTACHED,
  2970					       PD_T_CC_DEBOUNCE);
  2971			else if (tcpm_port_is_audio(port))
  2972				tcpm_set_state(port, AUDIO_ACC_ATTACHED,
  2973					       PD_T_CC_DEBOUNCE);
  2974			else if (tcpm_port_is_source(port))
  2975				tcpm_set_state(port,
  2976					       tcpm_try_snk(port) ? SNK_TRY
  2977								  : SRC_ATTACHED,
  2978					       PD_T_CC_DEBOUNCE);
  2979			break;
  2980	
  2981		case SNK_TRY:
  2982			port->try_snk_count++;
  2983			/*
  2984			 * Requirements:
  2985			 * - Do not drive vconn or vbus
  2986			 * - Terminate CC pins (both) to Rd
  2987			 * Action:
  2988			 * - Wait for tDRPTry (PD_T_DRP_TRY).
  2989			 *   Until then, ignore any state changes.
  2990			 */
  2991			tcpm_set_cc(port, TYPEC_CC_RD);
  2992			tcpm_set_state(port, SNK_TRY_WAIT, PD_T_DRP_TRY);
  2993			break;
  2994		case SNK_TRY_WAIT:
  2995			if (tcpm_port_is_sink(port)) {
  2996				tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE, 0);
  2997			} else {
  2998				tcpm_set_state(port, SRC_TRYWAIT, 0);
  2999				port->max_wait = 0;
  3000			}
  3001			break;
  3002		case SNK_TRY_WAIT_DEBOUNCE:
  3003			tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS,
  3004				       PD_T_PD_DEBOUNCE);
  3005			break;
  3006		case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
  3007			if (port->vbus_present && tcpm_port_is_sink(port)) {
  3008				tcpm_set_state(port, SNK_ATTACHED, 0);
  3009			} else {
  3010				tcpm_set_state(port, SRC_TRYWAIT, 0);
  3011				port->max_wait = 0;
  3012			}
  3013			break;
  3014		case SRC_TRYWAIT:
  3015			tcpm_set_cc(port, tcpm_rp_cc(port));
  3016			if (port->max_wait == 0) {
  3017				port->max_wait = jiffies +
  3018						 msecs_to_jiffies(PD_T_DRP_TRY);
  3019				tcpm_set_state(port, SRC_TRYWAIT_UNATTACHED,
  3020					       PD_T_DRP_TRY);
  3021			} else {
  3022				if (time_is_after_jiffies(port->max_wait))
  3023					tcpm_set_state(port, SRC_TRYWAIT_UNATTACHED,
  3024						       jiffies_to_msecs(port->max_wait -
  3025									jiffies));
  3026				else
  3027					tcpm_set_state(port, SNK_UNATTACHED, 0);
  3028			}
  3029			break;
  3030		case SRC_TRYWAIT_DEBOUNCE:
  3031			tcpm_set_state(port, SRC_ATTACHED, PD_T_CC_DEBOUNCE);
  3032			break;
  3033		case SRC_TRYWAIT_UNATTACHED:
  3034			tcpm_set_state(port, SNK_UNATTACHED, 0);
  3035			break;
  3036	
  3037		case SRC_ATTACHED:
  3038			ret = tcpm_src_attach(port);
  3039			tcpm_set_state(port, SRC_UNATTACHED,
  3040				       ret < 0 ? 0 : PD_T_PS_SOURCE_ON);
  3041			break;
  3042		case SRC_STARTUP:
  3043			opmode =  tcpm_get_pwr_opmode(tcpm_rp_cc(port));
  3044			typec_set_pwr_opmode(port->typec_port, opmode);
  3045			port->pwr_opmode = TYPEC_PWR_MODE_USB;
  3046			port->caps_count = 0;
  3047			port->negotiated_rev = PD_MAX_REV;
  3048			port->message_id = 0;
  3049			port->rx_msgid = -1;
  3050			port->explicit_contract = false;
  3051			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
  3052			break;
  3053		case SRC_SEND_CAPABILITIES:
  3054			port->caps_count++;
  3055			if (port->caps_count > PD_N_CAPS_COUNT) {
  3056				tcpm_set_state(port, SRC_READY, 0);
  3057				break;
  3058			}
  3059			ret = tcpm_pd_send_source_caps(port);
  3060			if (ret < 0) {
  3061				tcpm_set_state(port, SRC_SEND_CAPABILITIES,
  3062					       PD_T_SEND_SOURCE_CAP);
  3063			} else {
  3064				/*
  3065				 * Per standard, we should clear the reset counter here.
  3066				 * However, that can result in state machine hang-ups.
  3067				 * Reset it only in READY state to improve stability.
  3068				 */
  3069				/* port->hard_reset_count = 0; */
  3070				port->caps_count = 0;
  3071				port->pd_capable = true;
  3072				tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
  3073						    PD_T_SEND_SOURCE_CAP);
  3074			}
  3075			break;
  3076		case SRC_SEND_CAPABILITIES_TIMEOUT:
  3077			/*
  3078			 * Error recovery for a PD_DATA_SOURCE_CAP reply timeout.
  3079			 *
  3080			 * PD 2.0 sinks are supposed to accept src-capabilities with a
  3081			 * 3.0 header and simply ignore any src PDOs which the sink does
  3082			 * not understand such as PPS but some 2.0 sinks instead ignore
  3083			 * the entire PD_DATA_SOURCE_CAP message, causing contract
  3084			 * negotiation to fail.
  3085			 *
  3086			 * After PD_N_HARD_RESET_COUNT hard-reset attempts, we try
  3087			 * sending src-capabilities with a lower PD revision to
  3088			 * make these broken sinks work.
  3089			 */
  3090			if (port->hard_reset_count < PD_N_HARD_RESET_COUNT) {
  3091				tcpm_set_state(port, HARD_RESET_SEND, 0);
  3092			} else if (port->negotiated_rev > PD_REV20) {
  3093				port->negotiated_rev--;
  3094				port->hard_reset_count = 0;
  3095				tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
  3096			} else {
  3097				tcpm_set_state(port, hard_reset_state(port), 0);
  3098			}
  3099			break;
  3100		case SRC_NEGOTIATE_CAPABILITIES:
  3101			ret = tcpm_pd_check_request(port);
  3102			if (ret < 0) {
  3103				tcpm_pd_send_control(port, PD_CTRL_REJECT);
  3104				if (!port->explicit_contract) {
  3105					tcpm_set_state(port,
  3106						       SRC_WAIT_NEW_CAPABILITIES, 0);
  3107				} else {
  3108					tcpm_set_state(port, SRC_READY, 0);
  3109				}
  3110			} else {
  3111				tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
  3112				tcpm_set_state(port, SRC_TRANSITION_SUPPLY,
  3113					       PD_T_SRC_TRANSITION);
  3114			}
  3115			break;
  3116		case SRC_TRANSITION_SUPPLY:
  3117			/* XXX: regulator_set_voltage(vbus, ...) */
  3118			tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
  3119			port->explicit_contract = true;
  3120			typec_set_pwr_opmode(port->typec_port, TYPEC_PWR_MODE_PD);
  3121			port->pwr_opmode = TYPEC_PWR_MODE_PD;
  3122			tcpm_set_state_cond(port, SRC_READY, 0);
  3123			break;
  3124		case SRC_READY:
  3125	#if 1
  3126			port->hard_reset_count = 0;
  3127	#endif
  3128			port->try_src_count = 0;
  3129	
  3130			tcpm_swap_complete(port, 0);
  3131			tcpm_typec_connect(port);
  3132	
  3133			tcpm_check_send_discover(port);
  3134			/*
  3135			 * 6.3.5
  3136			 * Sending ping messages is not necessary if
  3137			 * - the source operates at vSafe5V
  3138			 * or
  3139			 * - The system is not operating in PD mode
  3140			 * or
  3141			 * - Both partners are connected using a Type-C connector
  3142			 *
  3143			 * There is no actual need to send PD messages since the local
  3144			 * port type-c and the spec does not clearly say whether PD is
  3145			 * possible when type-c is connected to Type-A/B
  3146			 */
  3147			break;
  3148		case SRC_WAIT_NEW_CAPABILITIES:
  3149			/* Nothing to do... */
  3150			break;
  3151	
  3152		/* SNK states */
  3153		case SNK_UNATTACHED:
  3154			if (!port->non_pd_role_swap)
  3155				tcpm_swap_complete(port, -ENOTCONN);
  3156			tcpm_pps_complete(port, -ENOTCONN);
  3157			tcpm_snk_detach(port);
  3158			if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
  3159				tcpm_set_state(port, TOGGLING, 0);
  3160				break;
  3161			}
  3162			tcpm_set_cc(port, TYPEC_CC_RD);
  3163			if (port->port_type == TYPEC_PORT_DRP)
  3164				tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
  3165			break;
  3166		case SNK_ATTACH_WAIT:
  3167			if ((port->cc1 == TYPEC_CC_OPEN &&
  3168			     port->cc2 != TYPEC_CC_OPEN) ||
  3169			    (port->cc1 != TYPEC_CC_OPEN &&
  3170			     port->cc2 == TYPEC_CC_OPEN))
  3171				tcpm_set_state(port, SNK_DEBOUNCED,
  3172					       PD_T_CC_DEBOUNCE);
  3173			else if (tcpm_port_is_disconnected(port))
  3174				tcpm_set_state(port, SNK_UNATTACHED,
  3175					       PD_T_PD_DEBOUNCE);
  3176			break;
  3177		case SNK_DEBOUNCED:
  3178			if (tcpm_port_is_disconnected(port))
  3179				tcpm_set_state(port, SNK_UNATTACHED,
  3180					       PD_T_PD_DEBOUNCE);
  3181			else if (port->vbus_present)
  3182				tcpm_set_state(port,
  3183					       tcpm_try_src(port) ? SRC_TRY
  3184								  : SNK_ATTACHED,
  3185					       0);
  3186			else
  3187				/* Wait for VBUS, but not forever */
  3188				tcpm_set_state(port, PORT_RESET, PD_T_PS_SOURCE_ON);
  3189			break;
  3190	
  3191		case SRC_TRY:
  3192			port->try_src_count++;
  3193			tcpm_set_cc(port, tcpm_rp_cc(port));
  3194			port->max_wait = 0;
  3195			tcpm_set_state(port, SRC_TRY_WAIT, 0);
  3196			break;
  3197		case SRC_TRY_WAIT:
  3198			if (port->max_wait == 0) {
  3199				port->max_wait = jiffies +
  3200						 msecs_to_jiffies(PD_T_DRP_TRY);
  3201				msecs = PD_T_DRP_TRY;
  3202			} else {
  3203				if (time_is_after_jiffies(port->max_wait))
  3204					msecs = jiffies_to_msecs(port->max_wait -
  3205								 jiffies);
  3206				else
  3207					msecs = 0;
  3208			}
  3209			tcpm_set_state(port, SNK_TRYWAIT, msecs);
  3210			break;
  3211		case SRC_TRY_DEBOUNCE:
  3212			tcpm_set_state(port, SRC_ATTACHED, PD_T_PD_DEBOUNCE);
  3213			break;
  3214		case SNK_TRYWAIT:
  3215			tcpm_set_cc(port, TYPEC_CC_RD);
  3216			tcpm_set_state(port, SNK_TRYWAIT_VBUS, PD_T_CC_DEBOUNCE);
  3217			break;
  3218		case SNK_TRYWAIT_VBUS:
  3219			/*
  3220			 * TCPM stays in this state indefinitely until VBUS
  3221			 * is detected as long as Rp is not detected for
  3222			 * more than a time period of tPDDebounce.
  3223			 */
  3224			if (port->vbus_present && tcpm_port_is_sink(port)) {
  3225				tcpm_set_state(port, SNK_ATTACHED, 0);
  3226				break;
  3227			}
  3228			if (!tcpm_port_is_sink(port))
  3229				tcpm_set_state(port, SNK_TRYWAIT_DEBOUNCE, 0);
  3230			break;
  3231		case SNK_TRYWAIT_DEBOUNCE:
  3232			tcpm_set_state(port, SNK_UNATTACHED, PD_T_PD_DEBOUNCE);
  3233			break;
  3234		case SNK_ATTACHED:
  3235			ret = tcpm_snk_attach(port);
  3236			if (ret < 0)
  3237				tcpm_set_state(port, SNK_UNATTACHED, 0);
  3238			else
  3239				tcpm_set_state(port, SNK_STARTUP, 0);
  3240			break;
  3241		case SNK_STARTUP:
  3242			opmode =  tcpm_get_pwr_opmode(port->polarity ?
  3243						      port->cc2 : port->cc1);
  3244			typec_set_pwr_opmode(port->typec_port, opmode);
  3245			port->pwr_opmode = TYPEC_PWR_MODE_USB;
  3246			port->negotiated_rev = PD_MAX_REV;
  3247			port->message_id = 0;
  3248			port->rx_msgid = -1;
  3249			port->explicit_contract = false;
  3250			tcpm_set_state(port, SNK_DISCOVERY, 0);
  3251			break;
  3252		case SNK_DISCOVERY:
  3253			if (port->vbus_present) {
  3254				if (port->psnkstdby_after_accept || tcpm_get_current_limit(port) <=
  3255				    PD_P_SNK_STDBY_5V)
  3256					tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
  3257				else
  3258					tcpm_set_current_limit(port, PD_P_SNK_STDBY_5V, 5000);
  3259				tcpm_set_charge(port, true);
  3260				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
  3261				break;
  3262			}
  3263			/*
  3264			 * For DRP, timeouts differ. Also, handling is supposed to be
  3265			 * different and much more complex (dead battery detection;
  3266			 * see USB power delivery specification, section 8.3.3.6.1.5.1).
  3267			 */
  3268			tcpm_set_state(port, hard_reset_state(port),
  3269				       port->port_type == TYPEC_PORT_DRP ?
  3270						PD_T_DB_DETECT : PD_T_NO_RESPONSE);
  3271			break;
  3272		case SNK_DISCOVERY_DEBOUNCE:
  3273			tcpm_set_state(port, SNK_DISCOVERY_DEBOUNCE_DONE,
  3274				       PD_T_CC_DEBOUNCE);
  3275			break;
  3276		case SNK_DISCOVERY_DEBOUNCE_DONE:
  3277			if (!tcpm_port_is_disconnected(port) &&
  3278			    tcpm_port_is_sink(port) &&
  3279			    time_is_after_jiffies(port->delayed_runtime)) {
  3280				tcpm_set_state(port, SNK_DISCOVERY,
  3281					       jiffies_to_msecs(port->delayed_runtime -
  3282								jiffies));
  3283				break;
  3284			}
  3285			tcpm_set_state(port, unattached_state(port), 0);
  3286			break;
  3287		case SNK_WAIT_CAPABILITIES:
  3288			ret = port->tcpc->set_pd_rx(port->tcpc, true);
  3289			if (ret < 0) {
  3290				tcpm_set_state(port, SNK_READY, 0);
  3291				break;
  3292			}
  3293			/*
  3294			 * If VBUS has never been low, and we time out waiting
  3295			 * for source cap, try a soft reset first, in case we
  3296			 * were already in a stable contract before this boot.
  3297			 * Do this only once.
  3298			 */
  3299			if (port->vbus_never_low) {
  3300				port->vbus_never_low = false;
  3301				tcpm_set_state(port, SOFT_RESET_SEND,
  3302					       PD_T_SINK_WAIT_CAP);
  3303			} else {
  3304				tcpm_set_state(port, hard_reset_state(port),
  3305					       PD_T_SINK_WAIT_CAP);
  3306			}
  3307			break;
  3308		case SNK_NEGOTIATE_CAPABILITIES:
  3309			port->pd_capable = true;
  3310			port->hard_reset_count = 0;
  3311			ret = tcpm_pd_send_request(port);
  3312			if (ret < 0) {
  3313				/* Let the Source send capabilities again. */
  3314				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
  3315			} else {
  3316				tcpm_set_state_cond(port, hard_reset_state(port),
  3317						    PD_T_SENDER_RESPONSE);
  3318			}
  3319			break;
  3320		case SNK_NEGOTIATE_PPS_CAPABILITIES:
  3321			ret = tcpm_pd_send_pps_request(port);
  3322			if (ret < 0) {
  3323				port->pps_status = ret;
  3324				/*
  3325				 * If this was called due to updates to sink
  3326				 * capabilities, and pps is no longer valid, we should
  3327				 * safely fall back to a standard PDO.
  3328				 */
  3329				if (port->update_sink_caps)
  3330					tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
  3331				else
  3332					tcpm_set_state(port, SNK_READY, 0);
  3333			} else {
  3334				tcpm_set_state_cond(port, hard_reset_state(port),
  3335						    PD_T_SENDER_RESPONSE);
  3336			}
  3337			break;
  3338		case SNK_TRANSITION_SINK:
> 3339			if (port->psnkstdby_after_accept)
  3340				tcpm_set_current_limit(port, tcpm_get_current_limit(port) >
  3341						       PD_P_SNK_STDBY_5V ? PD_P_SNK_STDBY_5V :
  3342						       tcpm_get_current_limit(port), 5000);
  3343		case SNK_TRANSITION_SINK_VBUS:
  3344			tcpm_set_state(port, hard_reset_state(port),
  3345				       PD_T_PS_TRANSITION);
  3346			break;
  3347		case SNK_READY:
  3348			port->try_snk_count = 0;
  3349			port->update_sink_caps = false;
  3350			if (port->explicit_contract) {
  3351				typec_set_pwr_opmode(port->typec_port,
  3352						     TYPEC_PWR_MODE_PD);
  3353				port->pwr_opmode = TYPEC_PWR_MODE_PD;
  3354			}
  3355	
  3356			/* Set current limit for NON-PD link when psnkstdby_after_accept is not set*/
  3357			if (!port->pd_capable && !port->psnkstdby_after_accept)
  3358				tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
  3359	
  3360			tcpm_swap_complete(port, 0);
  3361			tcpm_typec_connect(port);
  3362			tcpm_check_send_discover(port);
  3363			tcpm_pps_complete(port, port->pps_status);
  3364	
  3365			power_supply_changed(port->psy);
  3366	
  3367			break;
  3368	
  3369		/* Accessory states */
  3370		case ACC_UNATTACHED:
  3371			tcpm_acc_detach(port);
  3372			tcpm_set_state(port, SRC_UNATTACHED, 0);
  3373			break;
  3374		case DEBUG_ACC_ATTACHED:
  3375		case AUDIO_ACC_ATTACHED:
  3376			ret = tcpm_acc_attach(port);
  3377			if (ret < 0)
  3378				tcpm_set_state(port, ACC_UNATTACHED, 0);
  3379			break;
  3380		case AUDIO_ACC_DEBOUNCE:
  3381			tcpm_set_state(port, ACC_UNATTACHED, PD_T_CC_DEBOUNCE);
  3382			break;
  3383	
  3384		/* Hard_Reset states */
  3385		case HARD_RESET_SEND:
  3386			tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
  3387			tcpm_set_state(port, HARD_RESET_START, 0);
  3388			break;
  3389		case HARD_RESET_START:
  3390			port->hard_reset_count++;
  3391			port->tcpc->set_pd_rx(port->tcpc, false);
  3392			tcpm_unregister_altmodes(port);
  3393			port->send_discover = true;
  3394			if (port->pwr_role == TYPEC_SOURCE)
  3395				tcpm_set_state(port, SRC_HARD_RESET_VBUS_OFF,
  3396					       PD_T_PS_HARD_RESET);
  3397			else
  3398				tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
  3399			break;
  3400		case SRC_HARD_RESET_VBUS_OFF:
  3401			tcpm_set_vconn(port, true);
  3402			tcpm_set_vbus(port, false);
  3403			tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
  3404				       tcpm_data_role_for_source(port));
  3405			tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
  3406			break;
  3407		case SRC_HARD_RESET_VBUS_ON:
  3408			tcpm_set_vbus(port, true);
  3409			port->tcpc->set_pd_rx(port->tcpc, true);
  3410			tcpm_set_attached_state(port, true);
  3411			tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
  3412			break;
  3413		case SNK_HARD_RESET_SINK_OFF:
  3414			memset(&port->pps_data, 0, sizeof(port->pps_data));
  3415			tcpm_set_vconn(port, false);
  3416			if (port->pd_capable)
  3417				tcpm_set_charge(port, false);
  3418			tcpm_set_roles(port, port->self_powered, TYPEC_SINK,
  3419				       tcpm_data_role_for_sink(port));
  3420			/*
  3421			 * VBUS may or may not toggle, depending on the adapter.
  3422			 * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
  3423			 * directly after timeout.
  3424			 */
  3425			tcpm_set_state(port, SNK_HARD_RESET_SINK_ON, PD_T_SAFE_0V);
  3426			break;
  3427		case SNK_HARD_RESET_WAIT_VBUS:
  3428			/* Assume we're disconnected if VBUS doesn't come back. */
  3429			tcpm_set_state(port, SNK_UNATTACHED,
  3430				       PD_T_SRC_RECOVER_MAX + PD_T_SRC_TURN_ON);
  3431			break;
  3432		case SNK_HARD_RESET_SINK_ON:
  3433			/* Note: There is no guarantee that VBUS is on in this state */
  3434			/*
  3435			 * XXX:
  3436			 * The specification suggests that dual mode ports in sink
  3437			 * mode should transition to state PE_SRC_Transition_to_default.
  3438			 * See USB power delivery specification chapter 8.3.3.6.1.3.
  3439			 * This would mean to to
  3440			 * - turn off VCONN, reset power supply
  3441			 * - request hardware reset
  3442			 * - turn on VCONN
  3443			 * - Transition to state PE_Src_Startup
  3444			 * SNK only ports shall transition to state Snk_Startup
  3445			 * (see chapter 8.3.3.3.8).
  3446			 * Similar, dual-mode ports in source mode should transition
  3447			 * to PE_SNK_Transition_to_default.
  3448			 */
  3449			if (port->pd_capable) {
  3450				tcpm_set_current_limit(port,
  3451						       tcpm_get_current_limit(port),
  3452						       5000);
  3453				tcpm_set_charge(port, true);
  3454			}
  3455			tcpm_set_attached_state(port, true);
  3456			tcpm_set_state(port, SNK_STARTUP, 0);
  3457			break;
  3458	
  3459		/* Soft_Reset states */
  3460		case SOFT_RESET:
  3461			port->message_id = 0;
  3462			port->rx_msgid = -1;
  3463			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
  3464			if (port->pwr_role == TYPEC_SOURCE)
  3465				tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
  3466			else
  3467				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
  3468			break;
  3469		case SOFT_RESET_SEND:
  3470			port->message_id = 0;
  3471			port->rx_msgid = -1;
  3472			if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET))
  3473				tcpm_set_state_cond(port, hard_reset_state(port), 0);
  3474			else
  3475				tcpm_set_state_cond(port, hard_reset_state(port),
  3476						    PD_T_SENDER_RESPONSE);
  3477			break;
  3478	
  3479		/* DR_Swap states */
  3480		case DR_SWAP_SEND:
  3481			tcpm_pd_send_control(port, PD_CTRL_DR_SWAP);
  3482			tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
  3483					    PD_T_SENDER_RESPONSE);
  3484			break;
  3485		case DR_SWAP_ACCEPT:
  3486			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
  3487			tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
  3488			break;
  3489		case DR_SWAP_SEND_TIMEOUT:
  3490			tcpm_swap_complete(port, -ETIMEDOUT);
  3491			tcpm_set_state(port, ready_state(port), 0);
  3492			break;
  3493		case DR_SWAP_CHANGE_DR:
  3494			if (port->data_role == TYPEC_HOST) {
  3495				tcpm_unregister_altmodes(port);
  3496				tcpm_set_roles(port, true, port->pwr_role,
  3497					       TYPEC_DEVICE);
  3498			} else {
  3499				tcpm_set_roles(port, true, port->pwr_role,
  3500					       TYPEC_HOST);
  3501				port->send_discover = true;
  3502			}
  3503			tcpm_set_state(port, ready_state(port), 0);
  3504			break;
  3505	
  3506		/* PR_Swap states */
  3507		case PR_SWAP_ACCEPT:
  3508			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
  3509			tcpm_set_state(port, PR_SWAP_START, 0);
  3510			break;
  3511		case PR_SWAP_SEND:
  3512			tcpm_pd_send_control(port, PD_CTRL_PR_SWAP);
  3513			tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
  3514					    PD_T_SENDER_RESPONSE);
  3515			break;
  3516		case PR_SWAP_SEND_TIMEOUT:
  3517			tcpm_swap_complete(port, -ETIMEDOUT);
  3518			tcpm_set_state(port, ready_state(port), 0);
  3519			break;
  3520		case PR_SWAP_START:
  3521			if (port->pwr_role == TYPEC_SOURCE)
  3522				tcpm_set_state(port, PR_SWAP_SRC_SNK_TRANSITION_OFF,
  3523					       PD_T_SRC_TRANSITION);
  3524			else
  3525				tcpm_set_state(port, PR_SWAP_SNK_SRC_SINK_OFF, 0);
  3526			break;
  3527		case PR_SWAP_SRC_SNK_TRANSITION_OFF:
  3528			tcpm_set_vbus(port, false);
  3529			port->explicit_contract = false;
  3530			/* allow time for Vbus discharge, must be < tSrcSwapStdby */
  3531			tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF,
  3532				       PD_T_SRCSWAPSTDBY);
  3533			break;
  3534		case PR_SWAP_SRC_SNK_SOURCE_OFF:
  3535			tcpm_set_cc(port, TYPEC_CC_RD);
  3536			/* allow CC debounce */
  3537			tcpm_set_state(port, PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED,
  3538				       PD_T_CC_DEBOUNCE);
  3539			break;
  3540		case PR_SWAP_SRC_SNK_SOURCE_OFF_CC_DEBOUNCED:
  3541			/*
  3542			 * USB-PD standard, 6.2.1.4, Port Power Role:
  3543			 * "During the Power Role Swap Sequence, for the initial Source
  3544			 * Port, the Port Power Role field shall be set to Sink in the
  3545			 * PS_RDY Message indicating that the initial Source’s power
  3546			 * supply is turned off"
  3547			 */
  3548			tcpm_set_pwr_role(port, TYPEC_SINK);
  3549			if (tcpm_pd_send_control(port, PD_CTRL_PS_RDY)) {
  3550				tcpm_set_state(port, ERROR_RECOVERY, 0);
  3551				break;
  3552			}
  3553			tcpm_set_state_cond(port, SNK_UNATTACHED, PD_T_PS_SOURCE_ON);
  3554			break;
  3555		case PR_SWAP_SRC_SNK_SINK_ON:
  3556			tcpm_set_state(port, SNK_STARTUP, 0);
  3557			break;
  3558		case PR_SWAP_SNK_SRC_SINK_OFF:
  3559			tcpm_set_charge(port, false);
  3560			tcpm_set_state(port, hard_reset_state(port),
  3561				       PD_T_PS_SOURCE_OFF);
  3562			break;
  3563		case PR_SWAP_SNK_SRC_SOURCE_ON:
  3564			tcpm_set_cc(port, tcpm_rp_cc(port));
  3565			tcpm_set_vbus(port, true);
  3566			/*
  3567			 * allow time VBUS ramp-up, must be < tNewSrc
  3568			 * Also, this window overlaps with CC debounce as well.
  3569			 * So, Wait for the max of two which is PD_T_NEWSRC
  3570			 */
  3571			tcpm_set_state(port, PR_SWAP_SNK_SRC_SOURCE_ON_VBUS_RAMPED_UP,
  3572				       PD_T_NEWSRC);
  3573			break;
  3574		case PR_SWAP_SNK_SRC_SOURCE_ON_VBUS_RAMPED_UP:
  3575			/*
  3576			 * USB PD standard, 6.2.1.4:
  3577			 * "Subsequent Messages initiated by the Policy Engine,
  3578			 * such as the PS_RDY Message sent to indicate that Vbus
  3579			 * is ready, will have the Port Power Role field set to
  3580			 * Source."
  3581			 */
  3582			tcpm_set_pwr_role(port, TYPEC_SOURCE);
  3583			tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
  3584			tcpm_set_state(port, SRC_STARTUP, 0);
  3585			break;
  3586	
  3587		case VCONN_SWAP_ACCEPT:
  3588			tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
  3589			tcpm_set_state(port, VCONN_SWAP_START, 0);
  3590			break;
  3591		case VCONN_SWAP_SEND:
  3592			tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP);
  3593			tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
  3594				       PD_T_SENDER_RESPONSE);
  3595			break;
  3596		case VCONN_SWAP_SEND_TIMEOUT:
  3597			tcpm_swap_complete(port, -ETIMEDOUT);
  3598			tcpm_set_state(port, ready_state(port), 0);
  3599			break;
  3600		case VCONN_SWAP_START:
  3601			if (port->vconn_role == TYPEC_SOURCE)
  3602				tcpm_set_state(port, VCONN_SWAP_WAIT_FOR_VCONN, 0);
  3603			else
  3604				tcpm_set_state(port, VCONN_SWAP_TURN_ON_VCONN, 0);
  3605			break;
  3606		case VCONN_SWAP_WAIT_FOR_VCONN:
  3607			tcpm_set_state(port, hard_reset_state(port),
  3608				       PD_T_VCONN_SOURCE_ON);
  3609			break;
  3610		case VCONN_SWAP_TURN_ON_VCONN:
  3611			tcpm_set_vconn(port, true);
  3612			tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
  3613			tcpm_set_state(port, ready_state(port), 0);
  3614			break;
  3615		case VCONN_SWAP_TURN_OFF_VCONN:
  3616			tcpm_set_vconn(port, false);
  3617			tcpm_set_state(port, ready_state(port), 0);
  3618			break;
  3619	
  3620		case DR_SWAP_CANCEL:
  3621		case PR_SWAP_CANCEL:
  3622		case VCONN_SWAP_CANCEL:
  3623			tcpm_swap_complete(port, port->swap_status);
  3624			if (port->pwr_role == TYPEC_SOURCE)
  3625				tcpm_set_state(port, SRC_READY, 0);
  3626			else
  3627				tcpm_set_state(port, SNK_READY, 0);
  3628			break;
  3629	
  3630		case BIST_RX:
  3631			switch (BDO_MODE_MASK(port->bist_request)) {
  3632			case BDO_MODE_CARRIER2:
  3633				tcpm_pd_transmit(port, TCPC_TX_BIST_MODE_2, NULL);
  3634				tcpm_set_state(port, unattached_state(port),
  3635					       PD_T_BIST_CONT_MODE);
  3636				break;
  3637			case BDO_MODE_TESTDATA:
  3638				if (port->tcpc->set_bist_data) {
  3639					tcpm_log(port, "Enable BIST MODE TESTDATA");
  3640					port->tcpc->set_bist_data(port->tcpc, true);
  3641				}
  3642				break;
  3643			default:
  3644				break;
  3645			}
  3646			break;
  3647		case GET_STATUS_SEND:
  3648			tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
  3649			tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
  3650				       PD_T_SENDER_RESPONSE);
  3651			break;
  3652		case GET_STATUS_SEND_TIMEOUT:
  3653			tcpm_set_state(port, ready_state(port), 0);
  3654			break;
  3655		case GET_PPS_STATUS_SEND:
  3656			tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
  3657			tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
  3658				       PD_T_SENDER_RESPONSE);
  3659			break;
  3660		case GET_PPS_STATUS_SEND_TIMEOUT:
  3661			tcpm_set_state(port, ready_state(port), 0);
  3662			break;
  3663		case ERROR_RECOVERY:
  3664			tcpm_swap_complete(port, -EPROTO);
  3665			tcpm_pps_complete(port, -EPROTO);
  3666			tcpm_set_state(port, PORT_RESET, 0);
  3667			break;
  3668		case PORT_RESET:
  3669			tcpm_reset_port(port);
  3670			tcpm_set_cc(port, TYPEC_CC_OPEN);
  3671			tcpm_set_state(port, PORT_RESET_WAIT_OFF,
  3672				       PD_T_ERROR_RECOVERY);
  3673			break;
  3674		case PORT_RESET_WAIT_OFF:
  3675			tcpm_set_state(port,
  3676				       tcpm_default_state(port),
  3677				       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
  3678			break;
  3679		default:
  3680			WARN(1, "Unexpected port state %d\n", port->state);
  3681			break;
  3682		}
  3683	}
  3684	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--oyUTqETQ0mS9luUI--
