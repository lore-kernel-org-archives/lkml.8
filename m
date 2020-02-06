Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D3FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8619521741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBFKns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:43:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:44466 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgBFKns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:43:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="gz'50?scan'50,208,50";a="224967274"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2020 02:43:42 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izedJ-000C5H-UX; Thu, 06 Feb 2020 18:43:41 +0800
Date:   Thu, 6 Feb 2020 18:43:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sound/pci/hda/patch_hdmi.c:1086: undefined reference to
 `snd_hda_get_num_devices'
Message-ID: <202002061809.r3UYBZGx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7e4iuqenwqpwmpjt"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7e4iuqenwqpwmpjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4c7d00ccf40db99bfb7bd1857bcbf007275704d8
commit: aa2b4a59871a0528bccb91ad94768c9dc2b7bb3d ASoC: Intel: boards: fix incorrect HDMI Kconfig dependency
date:   7 weeks ago
config: i386-randconfig-e003-20200206 (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        git checkout aa2b4a59871a0528bccb91ad94768c9dc2b7bb3d
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: sound/pci/hda/patch_hdmi.o: in function `intel_not_share_assigned_cvt':
>> sound/pci/hda/patch_hdmi.c:1086: undefined reference to `snd_hda_get_num_devices'
>> ld: sound/pci/hda/patch_hdmi.c:1098: undefined reference to `snd_hda_get_dev_select'
>> ld: sound/pci/hda/patch_hdmi.c:1099: undefined reference to `snd_hda_set_dev_select'
   ld: sound/pci/hda/patch_hdmi.c:1123: undefined reference to `snd_hda_set_dev_select'
   ld: sound/pci/hda/patch_hdmi.o: in function `check_non_pcm_per_cvt':
>> sound/pci/hda/patch_hdmi.c:1894: undefined reference to `snd_hda_spdif_out_of_nid'
   ld: sound/pci/hda/patch_hdmi.o: in function `reprogram_jack_detect':
>> sound/pci/hda/patch_hdmi.c:2490: undefined reference to `snd_hda_jack_tbl_get_mst'
>> ld: sound/pci/hda/patch_hdmi.c:2503: undefined reference to `snd_hda_jack_detect_enable'
   ld: sound/pci/hda/patch_hdmi.o: in function `generic_hdmi_build_pcms':
>> sound/pci/hda/patch_hdmi.c:2144: undefined reference to `snd_hda_codec_pcm_new'
   ld: sound/pci/hda/patch_hdmi.o: in function `generic_hdmi_playback_pcm_cleanup':
>> sound/pci/hda/patch_hdmi.c:1996: undefined reference to `__snd_hda_codec_cleanup_stream'
   ld: sound/pci/hda/patch_hdmi.o: in function `generic_hdmi_build_jack':
>> sound/pci/hda/patch_hdmi.c:2213: undefined reference to `is_jack_detectable'
>> ld: sound/pci/hda/patch_hdmi.c:2217: undefined reference to `snd_hda_jack_add_kctl_mst'
>> ld: sound/pci/hda/patch_hdmi.c:2222: undefined reference to `snd_hda_jack_tbl_get_mst'
   ld: sound/pci/hda/patch_hdmi.o: in function `hdmi_pin_get_eld':
>> sound/pci/hda/patch_hdmi.c:646: undefined reference to `snd_hda_set_dev_select'
   ld: sound/pci/hda/patch_hdmi.o: in function `intel_haswell_enable_all_pins':
>> sound/pci/hda/patch_hdmi.c:2640: undefined reference to `snd_hda_codec_update_widgets'
   ld: sound/pci/hda/patch_hdmi.o: in function `simple_hdmi_unsol_event':
>> sound/pci/hda/patch_hdmi.c:2978: undefined reference to `snd_hda_jack_set_dirty_all'
>> ld: sound/pci/hda/patch_hdmi.c:2979: undefined reference to `snd_hda_jack_report_sync'
   ld: sound/pci/hda/patch_hdmi.o: in function `simple_playback_pcm_prepare':
>> sound/pci/hda/patch_hdmi.c:3159: undefined reference to `snd_hda_multi_out_dig_prepare'
   ld: sound/pci/hda/patch_hdmi.o: in function `simple_playback_pcm_close':
>> sound/pci/hda/patch_hdmi.c:3149: undefined reference to `snd_hda_multi_out_dig_close'
   ld: sound/pci/hda/patch_hdmi.o: in function `simple_playback_pcm_open':
>> sound/pci/hda/patch_hdmi.c:3141: undefined reference to `snd_hda_multi_out_dig_open'
   ld: sound/pci/hda/patch_hdmi.o: in function `nvhdmi_7x_init_8ch':
>> sound/pci/hda/patch_hdmi.c:3087: undefined reference to `snd_hda_sequence_write'
   ld: sound/pci/hda/patch_hdmi.o: in function `nvhdmi_7x_init_2ch':
   sound/pci/hda/patch_hdmi.c:3081: undefined reference to `snd_hda_sequence_write'
   ld: sound/pci/hda/patch_hdmi.o: in function `hdmi_pcm_open':
   sound/pci/hda/patch_hdmi.c:1257: undefined reference to `snd_hda_set_dev_select'
>> ld: sound/pci/hda/patch_hdmi.c:1265: undefined reference to `snd_hda_spdif_ctls_assign'

vim +1086 sound/pci/hda/patch_hdmi.c

307229d2ac5f604 Anssi Hannula     2013-10-24   921  
307229d2ac5f604 Anssi Hannula     2013-10-24   922  static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
9c32fea836928d7 Nikhil Mahale     2019-11-19   923  			      hda_nid_t pin_nid, int dev_id,
9c32fea836928d7 Nikhil Mahale     2019-11-19   924  			      u32 stream_tag, int format)
307229d2ac5f604 Anssi Hannula     2013-10-24   925  {
307229d2ac5f604 Anssi Hannula     2013-10-24   926  	struct hdmi_spec *spec = codec->spec;
5a5d718f952b55e Sriram Periyasamy 2017-09-19   927  	unsigned int param;
307229d2ac5f604 Anssi Hannula     2013-10-24   928  	int err;
307229d2ac5f604 Anssi Hannula     2013-10-24   929  
9c32fea836928d7 Nikhil Mahale     2019-11-19   930  	err = spec->ops.pin_hbr_setup(codec, pin_nid, dev_id,
9c32fea836928d7 Nikhil Mahale     2019-11-19   931  				      is_hbr_format(format));
307229d2ac5f604 Anssi Hannula     2013-10-24   932  
307229d2ac5f604 Anssi Hannula     2013-10-24   933  	if (err) {
4e76a8833fac8dc Takashi Iwai      2014-02-25   934  		codec_dbg(codec, "hdmi_setup_stream: HBR is not supported\n");
307229d2ac5f604 Anssi Hannula     2013-10-24   935  		return err;
ea87d1c493aba9c Anssi Hannula     2010-08-03   936  	}
079d88ccc374d2c Wu Fengguang      2010-03-08   937  
cb45722b289b544 Takashi Iwai      2019-11-11   938  	if (spec->intel_hsw_fixup) {
5a5d718f952b55e Sriram Periyasamy 2017-09-19   939  
5a5d718f952b55e Sriram Periyasamy 2017-09-19   940  		/*
5a5d718f952b55e Sriram Periyasamy 2017-09-19   941  		 * on recent platforms IEC Coding Type is required for HBR
5a5d718f952b55e Sriram Periyasamy 2017-09-19   942  		 * support, read current Digital Converter settings and set
5a5d718f952b55e Sriram Periyasamy 2017-09-19   943  		 * ICT bitfield if needed.
5a5d718f952b55e Sriram Periyasamy 2017-09-19   944  		 */
5a5d718f952b55e Sriram Periyasamy 2017-09-19   945  		param = snd_hda_codec_read(codec, cvt_nid, 0,
5a5d718f952b55e Sriram Periyasamy 2017-09-19   946  					   AC_VERB_GET_DIGI_CONVERT_1, 0);
5a5d718f952b55e Sriram Periyasamy 2017-09-19   947  
5a5d718f952b55e Sriram Periyasamy 2017-09-19   948  		param = (param >> 16) & ~(AC_DIG3_ICT);
5a5d718f952b55e Sriram Periyasamy 2017-09-19   949  
5a5d718f952b55e Sriram Periyasamy 2017-09-19   950  		/* on recent platforms ICT mode is required for HBR support */
5a5d718f952b55e Sriram Periyasamy 2017-09-19   951  		if (is_hbr_format(format))
5a5d718f952b55e Sriram Periyasamy 2017-09-19   952  			param |= 0x1;
5a5d718f952b55e Sriram Periyasamy 2017-09-19   953  
5a5d718f952b55e Sriram Periyasamy 2017-09-19   954  		snd_hda_codec_write(codec, cvt_nid, 0,
5a5d718f952b55e Sriram Periyasamy 2017-09-19   955  				    AC_VERB_SET_DIGI_CONVERT_3, param);
5a5d718f952b55e Sriram Periyasamy 2017-09-19   956  	}
5a5d718f952b55e Sriram Periyasamy 2017-09-19   957  
384a48d71520ca5 Stephen Warren    2011-06-01  @958  	snd_hda_codec_setup_stream(codec, cvt_nid, stream_tag, 0, format);
ea87d1c493aba9c Anssi Hannula     2010-08-03   959  	return 0;
079d88ccc374d2c Wu Fengguang      2010-03-08   960  }
079d88ccc374d2c Wu Fengguang      2010-03-08   961  
42b2987079eca02 Libin Yang        2015-12-16   962  /* Try to find an available converter
42b2987079eca02 Libin Yang        2015-12-16   963   * If pin_idx is less then zero, just try to find an available converter.
42b2987079eca02 Libin Yang        2015-12-16   964   * Otherwise, try to find an available converter and get the cvt mux index
42b2987079eca02 Libin Yang        2015-12-16   965   * of the pin.
42b2987079eca02 Libin Yang        2015-12-16   966   */
7ef166b831237e6 Wang Xingchao     2013-06-18   967  static int hdmi_choose_cvt(struct hda_codec *codec,
4846a67eb5a1d7c Takashi Iwai      2016-03-21   968  			   int pin_idx, int *cvt_id)
bbbe33900d1f3c4 Takashi Iwai      2010-08-13   969  {
bbbe33900d1f3c4 Takashi Iwai      2010-08-13   970  	struct hdmi_spec *spec = codec->spec;
384a48d71520ca5 Stephen Warren    2011-06-01   971  	struct hdmi_spec_per_pin *per_pin;
384a48d71520ca5 Stephen Warren    2011-06-01   972  	struct hdmi_spec_per_cvt *per_cvt = NULL;
7ef166b831237e6 Wang Xingchao     2013-06-18   973  	int cvt_idx, mux_idx = 0;
bbbe33900d1f3c4 Takashi Iwai      2010-08-13   974  
42b2987079eca02 Libin Yang        2015-12-16   975  	/* pin_idx < 0 means no pin will be bound to the converter */
42b2987079eca02 Libin Yang        2015-12-16   976  	if (pin_idx < 0)
42b2987079eca02 Libin Yang        2015-12-16   977  		per_pin = NULL;
42b2987079eca02 Libin Yang        2015-12-16   978  	else
bce0d2a80e428aa Takashi Iwai      2013-03-13   979  		per_pin = get_pin(spec, pin_idx);
384a48d71520ca5 Stephen Warren    2011-06-01   980  
384a48d71520ca5 Stephen Warren    2011-06-01   981  	/* Dynamically assign converter to stream */
384a48d71520ca5 Stephen Warren    2011-06-01   982  	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
bce0d2a80e428aa Takashi Iwai      2013-03-13   983  		per_cvt = get_cvt(spec, cvt_idx);
384a48d71520ca5 Stephen Warren    2011-06-01   984  
384a48d71520ca5 Stephen Warren    2011-06-01   985  		/* Must not already be assigned */
384a48d71520ca5 Stephen Warren    2011-06-01   986  		if (per_cvt->assigned)
384a48d71520ca5 Stephen Warren    2011-06-01   987  			continue;
42b2987079eca02 Libin Yang        2015-12-16   988  		if (per_pin == NULL)
42b2987079eca02 Libin Yang        2015-12-16   989  			break;
384a48d71520ca5 Stephen Warren    2011-06-01   990  		/* Must be in pin's mux's list of converters */
384a48d71520ca5 Stephen Warren    2011-06-01   991  		for (mux_idx = 0; mux_idx < per_pin->num_mux_nids; mux_idx++)
384a48d71520ca5 Stephen Warren    2011-06-01   992  			if (per_pin->mux_nids[mux_idx] == per_cvt->cvt_nid)
384a48d71520ca5 Stephen Warren    2011-06-01   993  				break;
384a48d71520ca5 Stephen Warren    2011-06-01   994  		/* Not in mux list */
384a48d71520ca5 Stephen Warren    2011-06-01   995  		if (mux_idx == per_pin->num_mux_nids)
384a48d71520ca5 Stephen Warren    2011-06-01   996  			continue;
384a48d71520ca5 Stephen Warren    2011-06-01   997  		break;
384a48d71520ca5 Stephen Warren    2011-06-01   998  	}
7ef166b831237e6 Wang Xingchao     2013-06-18   999  
384a48d71520ca5 Stephen Warren    2011-06-01  1000  	/* No free converters */
384a48d71520ca5 Stephen Warren    2011-06-01  1001  	if (cvt_idx == spec->num_cvts)
42b2987079eca02 Libin Yang        2015-12-16  1002  		return -EBUSY;
bbbe33900d1f3c4 Takashi Iwai      2010-08-13  1003  
42b2987079eca02 Libin Yang        2015-12-16  1004  	if (per_pin != NULL)
2df6742f613840a Mengdong Lin      2014-03-20  1005  		per_pin->mux_idx = mux_idx;
2df6742f613840a Mengdong Lin      2014-03-20  1006  
7ef166b831237e6 Wang Xingchao     2013-06-18  1007  	if (cvt_id)
7ef166b831237e6 Wang Xingchao     2013-06-18  1008  		*cvt_id = cvt_idx;
7ef166b831237e6 Wang Xingchao     2013-06-18  1009  
7ef166b831237e6 Wang Xingchao     2013-06-18  1010  	return 0;
7ef166b831237e6 Wang Xingchao     2013-06-18  1011  }
7ef166b831237e6 Wang Xingchao     2013-06-18  1012  
2df6742f613840a Mengdong Lin      2014-03-20  1013  /* Assure the pin select the right convetor */
2df6742f613840a Mengdong Lin      2014-03-20  1014  static void intel_verify_pin_cvt_connect(struct hda_codec *codec,
2df6742f613840a Mengdong Lin      2014-03-20  1015  			struct hdmi_spec_per_pin *per_pin)
2df6742f613840a Mengdong Lin      2014-03-20  1016  {
2df6742f613840a Mengdong Lin      2014-03-20  1017  	hda_nid_t pin_nid = per_pin->pin_nid;
2df6742f613840a Mengdong Lin      2014-03-20  1018  	int mux_idx, curr;
2df6742f613840a Mengdong Lin      2014-03-20  1019  
2df6742f613840a Mengdong Lin      2014-03-20  1020  	mux_idx = per_pin->mux_idx;
2df6742f613840a Mengdong Lin      2014-03-20  1021  	curr = snd_hda_codec_read(codec, pin_nid, 0,
2df6742f613840a Mengdong Lin      2014-03-20  1022  					  AC_VERB_GET_CONNECT_SEL, 0);
2df6742f613840a Mengdong Lin      2014-03-20  1023  	if (curr != mux_idx)
2df6742f613840a Mengdong Lin      2014-03-20  1024  		snd_hda_codec_write_cache(codec, pin_nid, 0,
2df6742f613840a Mengdong Lin      2014-03-20  1025  					    AC_VERB_SET_CONNECT_SEL,
2df6742f613840a Mengdong Lin      2014-03-20  1026  					    mux_idx);
2df6742f613840a Mengdong Lin      2014-03-20  1027  }
2df6742f613840a Mengdong Lin      2014-03-20  1028  
42b2987079eca02 Libin Yang        2015-12-16  1029  /* get the mux index for the converter of the pins
42b2987079eca02 Libin Yang        2015-12-16  1030   * converter's mux index is the same for all pins on Intel platform
42b2987079eca02 Libin Yang        2015-12-16  1031   */
42b2987079eca02 Libin Yang        2015-12-16  1032  static int intel_cvt_id_to_mux_idx(struct hdmi_spec *spec,
42b2987079eca02 Libin Yang        2015-12-16  1033  			hda_nid_t cvt_nid)
42b2987079eca02 Libin Yang        2015-12-16  1034  {
42b2987079eca02 Libin Yang        2015-12-16  1035  	int i;
42b2987079eca02 Libin Yang        2015-12-16  1036  
42b2987079eca02 Libin Yang        2015-12-16  1037  	for (i = 0; i < spec->num_cvts; i++)
42b2987079eca02 Libin Yang        2015-12-16  1038  		if (spec->cvt_nids[i] == cvt_nid)
42b2987079eca02 Libin Yang        2015-12-16  1039  			return i;
42b2987079eca02 Libin Yang        2015-12-16  1040  	return -EINVAL;
42b2987079eca02 Libin Yang        2015-12-16  1041  }
42b2987079eca02 Libin Yang        2015-12-16  1042  
300016b960661b4 Mengdong Lin      2013-11-04  1043  /* Intel HDMI workaround to fix audio routing issue:
300016b960661b4 Mengdong Lin      2013-11-04  1044   * For some Intel display codecs, pins share the same connection list.
300016b960661b4 Mengdong Lin      2013-11-04  1045   * So a conveter can be selected by multiple pins and playback on any of these
300016b960661b4 Mengdong Lin      2013-11-04  1046   * pins will generate sound on the external display, because audio flows from
300016b960661b4 Mengdong Lin      2013-11-04  1047   * the same converter to the display pipeline. Also muting one pin may make
300016b960661b4 Mengdong Lin      2013-11-04  1048   * other pins have no sound output.
300016b960661b4 Mengdong Lin      2013-11-04  1049   * So this function assures that an assigned converter for a pin is not selected
300016b960661b4 Mengdong Lin      2013-11-04  1050   * by any other pins.
300016b960661b4 Mengdong Lin      2013-11-04  1051   */
300016b960661b4 Mengdong Lin      2013-11-04  1052  static void intel_not_share_assigned_cvt(struct hda_codec *codec,
9152085defb6426 Libin Yang        2017-01-12  1053  					 hda_nid_t pin_nid,
9152085defb6426 Libin Yang        2017-01-12  1054  					 int dev_id, int mux_idx)
7ef166b831237e6 Wang Xingchao     2013-06-18  1055  {
7ef166b831237e6 Wang Xingchao     2013-06-18  1056  	struct hdmi_spec *spec = codec->spec;
7639a06c23c7d4c Takashi Iwai      2015-03-03  1057  	hda_nid_t nid;
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1058  	int cvt_idx, curr;
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1059  	struct hdmi_spec_per_cvt *per_cvt;
9152085defb6426 Libin Yang        2017-01-12  1060  	struct hdmi_spec_per_pin *per_pin;
9152085defb6426 Libin Yang        2017-01-12  1061  	int pin_idx;
9152085defb6426 Libin Yang        2017-01-12  1062  
9152085defb6426 Libin Yang        2017-01-12  1063  	/* configure the pins connections */
9152085defb6426 Libin Yang        2017-01-12  1064  	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
9152085defb6426 Libin Yang        2017-01-12  1065  		int dev_id_saved;
9152085defb6426 Libin Yang        2017-01-12  1066  		int dev_num;
7ef166b831237e6 Wang Xingchao     2013-06-18  1067  
9152085defb6426 Libin Yang        2017-01-12  1068  		per_pin = get_pin(spec, pin_idx);
9152085defb6426 Libin Yang        2017-01-12  1069  		/*
9152085defb6426 Libin Yang        2017-01-12  1070  		 * pin not connected to monitor
9152085defb6426 Libin Yang        2017-01-12  1071  		 * no need to operate on it
9152085defb6426 Libin Yang        2017-01-12  1072  		 */
9152085defb6426 Libin Yang        2017-01-12  1073  		if (!per_pin->pcm)
9152085defb6426 Libin Yang        2017-01-12  1074  			continue;
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1075  
9152085defb6426 Libin Yang        2017-01-12  1076  		if ((per_pin->pin_nid == pin_nid) &&
9152085defb6426 Libin Yang        2017-01-12  1077  			(per_pin->dev_id == dev_id))
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1078  			continue;
7ef166b831237e6 Wang Xingchao     2013-06-18  1079  
9152085defb6426 Libin Yang        2017-01-12  1080  		/*
9152085defb6426 Libin Yang        2017-01-12  1081  		 * if per_pin->dev_id >= dev_num,
9152085defb6426 Libin Yang        2017-01-12  1082  		 * snd_hda_get_dev_select() will fail,
9152085defb6426 Libin Yang        2017-01-12  1083  		 * and the following operation is unpredictable.
9152085defb6426 Libin Yang        2017-01-12  1084  		 * So skip this situation.
9152085defb6426 Libin Yang        2017-01-12  1085  		 */
9152085defb6426 Libin Yang        2017-01-12 @1086  		dev_num = snd_hda_get_num_devices(codec, per_pin->pin_nid) + 1;
9152085defb6426 Libin Yang        2017-01-12  1087  		if (per_pin->dev_id >= dev_num)
7ef166b831237e6 Wang Xingchao     2013-06-18  1088  			continue;
7ef166b831237e6 Wang Xingchao     2013-06-18  1089  
9152085defb6426 Libin Yang        2017-01-12  1090  		nid = per_pin->pin_nid;
9152085defb6426 Libin Yang        2017-01-12  1091  
9152085defb6426 Libin Yang        2017-01-12  1092  		/*
9152085defb6426 Libin Yang        2017-01-12  1093  		 * Calling this function should not impact
9152085defb6426 Libin Yang        2017-01-12  1094  		 * on the device entry selection
9152085defb6426 Libin Yang        2017-01-12  1095  		 * So let's save the dev id for each pin,
9152085defb6426 Libin Yang        2017-01-12  1096  		 * and restore it when return
9152085defb6426 Libin Yang        2017-01-12  1097  		 */
9152085defb6426 Libin Yang        2017-01-12 @1098  		dev_id_saved = snd_hda_get_dev_select(codec, nid);
9152085defb6426 Libin Yang        2017-01-12 @1099  		snd_hda_set_dev_select(codec, nid, per_pin->dev_id);
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1100  		curr = snd_hda_codec_read(codec, nid, 0,
7ef166b831237e6 Wang Xingchao     2013-06-18  1101  					  AC_VERB_GET_CONNECT_SEL, 0);
9152085defb6426 Libin Yang        2017-01-12  1102  		if (curr != mux_idx) {
9152085defb6426 Libin Yang        2017-01-12  1103  			snd_hda_set_dev_select(codec, nid, dev_id_saved);
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1104  			continue;
9152085defb6426 Libin Yang        2017-01-12  1105  		}
9152085defb6426 Libin Yang        2017-01-12  1106  
7ef166b831237e6 Wang Xingchao     2013-06-18  1107  
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1108  		/* choose an unassigned converter. The conveters in the
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1109  		 * connection list are in the same order as in the codec.
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1110  		 */
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1111  		for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1112  			per_cvt = get_cvt(spec, cvt_idx);
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1113  			if (!per_cvt->assigned) {
4e76a8833fac8dc Takashi Iwai      2014-02-25  1114  				codec_dbg(codec,
4e76a8833fac8dc Takashi Iwai      2014-02-25  1115  					  "choose cvt %d for pin nid %d\n",
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1116  					cvt_idx, nid);
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1117  				snd_hda_codec_write_cache(codec, nid, 0,
7ef166b831237e6 Wang Xingchao     2013-06-18  1118  					    AC_VERB_SET_CONNECT_SEL,
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1119  					    cvt_idx);
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1120  				break;
f82d7d16aee5eb4 Mengdong Lin      2013-09-21  1121  			}
7ef166b831237e6 Wang Xingchao     2013-06-18  1122  		}
9152085defb6426 Libin Yang        2017-01-12  1123  		snd_hda_set_dev_select(codec, nid, dev_id_saved);
7ef166b831237e6 Wang Xingchao     2013-06-18  1124  	}
7ef166b831237e6 Wang Xingchao     2013-06-18  1125  }
7ef166b831237e6 Wang Xingchao     2013-06-18  1126  
42b2987079eca02 Libin Yang        2015-12-16  1127  /* A wrapper of intel_not_share_asigned_cvt() */
42b2987079eca02 Libin Yang        2015-12-16  1128  static void intel_not_share_assigned_cvt_nid(struct hda_codec *codec,
9152085defb6426 Libin Yang        2017-01-12  1129  			hda_nid_t pin_nid, int dev_id, hda_nid_t cvt_nid)
42b2987079eca02 Libin Yang        2015-12-16  1130  {
42b2987079eca02 Libin Yang        2015-12-16  1131  	int mux_idx;
42b2987079eca02 Libin Yang        2015-12-16  1132  	struct hdmi_spec *spec = codec->spec;
42b2987079eca02 Libin Yang        2015-12-16  1133  
42b2987079eca02 Libin Yang        2015-12-16  1134  	/* On Intel platform, the mapping of converter nid to
42b2987079eca02 Libin Yang        2015-12-16  1135  	 * mux index of the pins are always the same.
42b2987079eca02 Libin Yang        2015-12-16  1136  	 * The pin nid may be 0, this means all pins will not
42b2987079eca02 Libin Yang        2015-12-16  1137  	 * share the converter.
42b2987079eca02 Libin Yang        2015-12-16  1138  	 */
42b2987079eca02 Libin Yang        2015-12-16  1139  	mux_idx = intel_cvt_id_to_mux_idx(spec, cvt_nid);
42b2987079eca02 Libin Yang        2015-12-16  1140  	if (mux_idx >= 0)
9152085defb6426 Libin Yang        2017-01-12  1141  		intel_not_share_assigned_cvt(codec, pin_nid, dev_id, mux_idx);
42b2987079eca02 Libin Yang        2015-12-16  1142  }
42b2987079eca02 Libin Yang        2015-12-16  1143  
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1144  /* skeleton caller of pin_cvt_fixup ops */
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1145  static void pin_cvt_fixup(struct hda_codec *codec,
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1146  			  struct hdmi_spec_per_pin *per_pin,
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1147  			  hda_nid_t cvt_nid)
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1148  {
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1149  	struct hdmi_spec *spec = codec->spec;
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1150  
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1151  	if (spec->ops.pin_cvt_fixup)
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1152  		spec->ops.pin_cvt_fixup(codec, per_pin, cvt_nid);
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1153  }
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1154  
42b2987079eca02 Libin Yang        2015-12-16  1155  /* called in hdmi_pcm_open when no pin is assigned to the PCM
42b2987079eca02 Libin Yang        2015-12-16  1156   * in dyn_pcm_assign mode.
42b2987079eca02 Libin Yang        2015-12-16  1157   */
42b2987079eca02 Libin Yang        2015-12-16  1158  static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
42b2987079eca02 Libin Yang        2015-12-16  1159  			 struct hda_codec *codec,
42b2987079eca02 Libin Yang        2015-12-16  1160  			 struct snd_pcm_substream *substream)
42b2987079eca02 Libin Yang        2015-12-16  1161  {
42b2987079eca02 Libin Yang        2015-12-16  1162  	struct hdmi_spec *spec = codec->spec;
42b2987079eca02 Libin Yang        2015-12-16  1163  	struct snd_pcm_runtime *runtime = substream->runtime;
ac98379a751e37b Libin Yang        2015-12-16  1164  	int cvt_idx, pcm_idx;
42b2987079eca02 Libin Yang        2015-12-16  1165  	struct hdmi_spec_per_cvt *per_cvt = NULL;
42b2987079eca02 Libin Yang        2015-12-16  1166  	int err;
42b2987079eca02 Libin Yang        2015-12-16  1167  
ac98379a751e37b Libin Yang        2015-12-16  1168  	pcm_idx = hinfo_to_pcm_index(codec, hinfo);
ac98379a751e37b Libin Yang        2015-12-16  1169  	if (pcm_idx < 0)
ac98379a751e37b Libin Yang        2015-12-16  1170  		return -EINVAL;
ac98379a751e37b Libin Yang        2015-12-16  1171  
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1172  	err = hdmi_choose_cvt(codec, -1, &cvt_idx);
42b2987079eca02 Libin Yang        2015-12-16  1173  	if (err)
42b2987079eca02 Libin Yang        2015-12-16  1174  		return err;
42b2987079eca02 Libin Yang        2015-12-16  1175  
42b2987079eca02 Libin Yang        2015-12-16  1176  	per_cvt = get_cvt(spec, cvt_idx);
42b2987079eca02 Libin Yang        2015-12-16  1177  	per_cvt->assigned = 1;
42b2987079eca02 Libin Yang        2015-12-16  1178  	hinfo->nid = per_cvt->cvt_nid;
42b2987079eca02 Libin Yang        2015-12-16  1179  
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1180  	pin_cvt_fixup(codec, NULL, per_cvt->cvt_nid);
42b2987079eca02 Libin Yang        2015-12-16  1181  
ac98379a751e37b Libin Yang        2015-12-16  1182  	set_bit(pcm_idx, &spec->pcm_in_use);
42b2987079eca02 Libin Yang        2015-12-16  1183  	/* todo: setup spdif ctls assign */
42b2987079eca02 Libin Yang        2015-12-16  1184  
42b2987079eca02 Libin Yang        2015-12-16  1185  	/* Initially set the converter's capabilities */
42b2987079eca02 Libin Yang        2015-12-16  1186  	hinfo->channels_min = per_cvt->channels_min;
42b2987079eca02 Libin Yang        2015-12-16  1187  	hinfo->channels_max = per_cvt->channels_max;
42b2987079eca02 Libin Yang        2015-12-16  1188  	hinfo->rates = per_cvt->rates;
42b2987079eca02 Libin Yang        2015-12-16  1189  	hinfo->formats = per_cvt->formats;
42b2987079eca02 Libin Yang        2015-12-16  1190  	hinfo->maxbps = per_cvt->maxbps;
42b2987079eca02 Libin Yang        2015-12-16  1191  
42b2987079eca02 Libin Yang        2015-12-16  1192  	/* Store the updated parameters */
42b2987079eca02 Libin Yang        2015-12-16  1193  	runtime->hw.channels_min = hinfo->channels_min;
42b2987079eca02 Libin Yang        2015-12-16  1194  	runtime->hw.channels_max = hinfo->channels_max;
42b2987079eca02 Libin Yang        2015-12-16  1195  	runtime->hw.formats = hinfo->formats;
42b2987079eca02 Libin Yang        2015-12-16  1196  	runtime->hw.rates = hinfo->rates;
42b2987079eca02 Libin Yang        2015-12-16  1197  
42b2987079eca02 Libin Yang        2015-12-16  1198  	snd_pcm_hw_constraint_step(substream->runtime, 0,
42b2987079eca02 Libin Yang        2015-12-16  1199  				   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
42b2987079eca02 Libin Yang        2015-12-16  1200  	return 0;
42b2987079eca02 Libin Yang        2015-12-16  1201  }
42b2987079eca02 Libin Yang        2015-12-16  1202  
7ef166b831237e6 Wang Xingchao     2013-06-18  1203  /*
7ef166b831237e6 Wang Xingchao     2013-06-18  1204   * HDA PCM callbacks
7ef166b831237e6 Wang Xingchao     2013-06-18  1205   */
7ef166b831237e6 Wang Xingchao     2013-06-18  1206  static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
7ef166b831237e6 Wang Xingchao     2013-06-18  1207  			 struct hda_codec *codec,
7ef166b831237e6 Wang Xingchao     2013-06-18  1208  			 struct snd_pcm_substream *substream)
7ef166b831237e6 Wang Xingchao     2013-06-18  1209  {
7ef166b831237e6 Wang Xingchao     2013-06-18  1210  	struct hdmi_spec *spec = codec->spec;
7ef166b831237e6 Wang Xingchao     2013-06-18  1211  	struct snd_pcm_runtime *runtime = substream->runtime;
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1212  	int pin_idx, cvt_idx, pcm_idx;
7ef166b831237e6 Wang Xingchao     2013-06-18  1213  	struct hdmi_spec_per_pin *per_pin;
7ef166b831237e6 Wang Xingchao     2013-06-18  1214  	struct hdmi_eld *eld;
7ef166b831237e6 Wang Xingchao     2013-06-18  1215  	struct hdmi_spec_per_cvt *per_cvt = NULL;
7ef166b831237e6 Wang Xingchao     2013-06-18  1216  	int err;
7ef166b831237e6 Wang Xingchao     2013-06-18  1217  
7ef166b831237e6 Wang Xingchao     2013-06-18  1218  	/* Validate hinfo */
2bf3c85a5b167a6 Libin Yang        2015-12-16  1219  	pcm_idx = hinfo_to_pcm_index(codec, hinfo);
2bf3c85a5b167a6 Libin Yang        2015-12-16  1220  	if (pcm_idx < 0)
2bf3c85a5b167a6 Libin Yang        2015-12-16  1221  		return -EINVAL;
2bf3c85a5b167a6 Libin Yang        2015-12-16  1222  
42b2987079eca02 Libin Yang        2015-12-16  1223  	mutex_lock(&spec->pcm_lock);
4e76a8833fac8dc Takashi Iwai      2014-02-25  1224  	pin_idx = hinfo_to_pin_index(codec, hinfo);
42b2987079eca02 Libin Yang        2015-12-16  1225  	if (!spec->dyn_pcm_assign) {
42b2987079eca02 Libin Yang        2015-12-16  1226  		if (snd_BUG_ON(pin_idx < 0)) {
f69548ffafcc494 Takashi Iwai      2018-07-12  1227  			err = -EINVAL;
f69548ffafcc494 Takashi Iwai      2018-07-12  1228  			goto unlock;
42b2987079eca02 Libin Yang        2015-12-16  1229  		}
42b2987079eca02 Libin Yang        2015-12-16  1230  	} else {
42b2987079eca02 Libin Yang        2015-12-16  1231  		/* no pin is assigned to the PCM
42b2987079eca02 Libin Yang        2015-12-16  1232  		 * PA need pcm open successfully when probe
42b2987079eca02 Libin Yang        2015-12-16  1233  		 */
42b2987079eca02 Libin Yang        2015-12-16  1234  		if (pin_idx < 0) {
42b2987079eca02 Libin Yang        2015-12-16  1235  			err = hdmi_pcm_open_no_pin(hinfo, codec, substream);
f69548ffafcc494 Takashi Iwai      2018-07-12  1236  			goto unlock;
42b2987079eca02 Libin Yang        2015-12-16  1237  		}
42b2987079eca02 Libin Yang        2015-12-16  1238  	}
7ef166b831237e6 Wang Xingchao     2013-06-18  1239  
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1240  	err = hdmi_choose_cvt(codec, pin_idx, &cvt_idx);
f69548ffafcc494 Takashi Iwai      2018-07-12  1241  	if (err < 0)
f69548ffafcc494 Takashi Iwai      2018-07-12  1242  		goto unlock;
7ef166b831237e6 Wang Xingchao     2013-06-18  1243  
7ef166b831237e6 Wang Xingchao     2013-06-18  1244  	per_cvt = get_cvt(spec, cvt_idx);
384a48d71520ca5 Stephen Warren    2011-06-01  1245  	/* Claim converter */
384a48d71520ca5 Stephen Warren    2011-06-01  1246  	per_cvt->assigned = 1;
42b2987079eca02 Libin Yang        2015-12-16  1247  
ac98379a751e37b Libin Yang        2015-12-16  1248  	set_bit(pcm_idx, &spec->pcm_in_use);
42b2987079eca02 Libin Yang        2015-12-16  1249  	per_pin = get_pin(spec, pin_idx);
1df5a06abbaa876 Anssi Hannula     2013-10-05  1250  	per_pin->cvt_nid = per_cvt->cvt_nid;
384a48d71520ca5 Stephen Warren    2011-06-01  1251  	hinfo->nid = per_cvt->cvt_nid;
384a48d71520ca5 Stephen Warren    2011-06-01  1252  
e38e486d66e2a3b Takashi Iwai      2019-12-02  1253  	/* flip stripe flag for the assigned stream if supported */
e38e486d66e2a3b Takashi Iwai      2019-12-02  1254  	if (get_wcaps(codec, per_cvt->cvt_nid) & AC_WCAP_STRIPE)
e38e486d66e2a3b Takashi Iwai      2019-12-02  1255  		azx_stream(get_azx_dev(substream))->stripe = 1;
e38e486d66e2a3b Takashi Iwai      2019-12-02  1256  
9152085defb6426 Libin Yang        2017-01-12  1257  	snd_hda_set_dev_select(codec, per_pin->pin_nid, per_pin->dev_id);
bddee96b5d0db86 Takashi Iwai      2013-06-18  1258  	snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
384a48d71520ca5 Stephen Warren    2011-06-01  1259  			    AC_VERB_SET_CONNECT_SEL,
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1260  			    per_pin->mux_idx);
7ef166b831237e6 Wang Xingchao     2013-06-18  1261  
7ef166b831237e6 Wang Xingchao     2013-06-18  1262  	/* configure unused pins to choose other converters */
4846a67eb5a1d7c Takashi Iwai      2016-03-21  1263  	pin_cvt_fixup(codec, per_pin, 0);
7ef166b831237e6 Wang Xingchao     2013-06-18  1264  
2bf3c85a5b167a6 Libin Yang        2015-12-16 @1265  	snd_hda_spdif_ctls_assign(codec, pcm_idx, per_cvt->cvt_nid);
bbbe33900d1f3c4 Takashi Iwai      2010-08-13  1266  
2def8172c6611f2 Stephen Warren    2011-06-01  1267  	/* Initially set the converter's capabilities */
384a48d71520ca5 Stephen Warren    2011-06-01  1268  	hinfo->channels_min = per_cvt->channels_min;
384a48d71520ca5 Stephen Warren    2011-06-01  1269  	hinfo->channels_max = per_cvt->channels_max;
384a48d71520ca5 Stephen Warren    2011-06-01  1270  	hinfo->rates = per_cvt->rates;
384a48d71520ca5 Stephen Warren    2011-06-01  1271  	hinfo->formats = per_cvt->formats;
384a48d71520ca5 Stephen Warren    2011-06-01  1272  	hinfo->maxbps = per_cvt->maxbps;
2def8172c6611f2 Stephen Warren    2011-06-01  1273  
42b2987079eca02 Libin Yang        2015-12-16  1274  	eld = &per_pin->sink_eld;
384a48d71520ca5 Stephen Warren    2011-06-01  1275  	/* Restrict capabilities by ELD if this isn't disabled */
c3d52105753dafd Stephen Warren    2011-06-01  1276  	if (!static_hdmi_pcm && eld->eld_valid) {
1613d6b46b433f0 David Henningsson 2013-02-19  1277  		snd_hdmi_eld_update_pcm_info(&eld->info, hinfo);
bbbe33900d1f3c4 Takashi Iwai      2010-08-13  1278  		if (hinfo->channels_min > hinfo->channels_max ||
2ad779b7329d689 Takashi Iwai      2013-02-01  1279  		    !hinfo->rates || !hinfo->formats) {
2ad779b7329d689 Takashi Iwai      2013-02-01  1280  			per_cvt->assigned = 0;
2ad779b7329d689 Takashi Iwai      2013-02-01  1281  			hinfo->nid = 0;
2bf3c85a5b167a6 Libin Yang        2015-12-16 @1282  			snd_hda_spdif_ctls_unassign(codec, pcm_idx);
f69548ffafcc494 Takashi Iwai      2018-07-12  1283  			err = -ENODEV;
f69548ffafcc494 Takashi Iwai      2018-07-12  1284  			goto unlock;
bbbe33900d1f3c4 Takashi Iwai      2010-08-13  1285  		}
2ad779b7329d689 Takashi Iwai      2013-02-01  1286  	}
2def8172c6611f2 Stephen Warren    2011-06-01  1287  
2def8172c6611f2 Stephen Warren    2011-06-01  1288  	/* Store the updated parameters */
639cef0eb6df05d Takashi Iwai      2011-01-14  1289  	runtime->hw.channels_min = hinfo->channels_min;
639cef0eb6df05d Takashi Iwai      2011-01-14  1290  	runtime->hw.channels_max = hinfo->channels_max;
639cef0eb6df05d Takashi Iwai      2011-01-14  1291  	runtime->hw.formats = hinfo->formats;
639cef0eb6df05d Takashi Iwai      2011-01-14  1292  	runtime->hw.rates = hinfo->rates;
4fe2ca14678174d Takashi Iwai      2011-01-14  1293  
4fe2ca14678174d Takashi Iwai      2011-01-14  1294  	snd_pcm_hw_constraint_step(substream->runtime, 0,
4fe2ca14678174d Takashi Iwai      2011-01-14  1295  				   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
f69548ffafcc494 Takashi Iwai      2018-07-12  1296   unlock:
f69548ffafcc494 Takashi Iwai      2018-07-12  1297  	mutex_unlock(&spec->pcm_lock);
f69548ffafcc494 Takashi Iwai      2018-07-12  1298  	return err;
bbbe33900d1f3c4 Takashi Iwai      2010-08-13  1299  }
bbbe33900d1f3c4 Takashi Iwai      2010-08-13  1300  

:::::: The code at line 1086 was first introduced by commit
:::::: 9152085defb6426ce8f9989ca27e4450daefbd89 ALSA: hda - add DP MST audio support

:::::: TO: Libin Yang <libin.yang@linux.intel.com>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--7e4iuqenwqpwmpjt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7e4iuqenwqpwmpjt--
